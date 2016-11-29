#!/usr/bin/python
"""
hex2bin

Class for transferring data between an internal memory image and files in
various file formats.

Can be used as a simple file to file data converter, e.g. Intel hex to 
binary or vice-versa, but mainly intended for providing CPU development 
tools with simple and reusable file IO.

By default the memory_image is mapped to addresses 0 ... memory_image_size-1 
but supplying a different starting address means that the memory_image can 
be mapped anywhere in the address space, e.g. from adr N ... N + memory_image_size-1.
This enables more efficient modelling of, say, the top 64K of memory for a 
1MByte CPU by requiring only a 64K buffer rather than a complete 1MByte 
buffer. 

The actual values provided for the buffer size and start position don't 
restrict the data which can be read since the buffer will grow in the
appropriate direction for data outside this range as required, up to
a maximum buffer size of 16MB.
"""
import re
import sys
import getopt

class Hex2Bin :

    _HEX_DIGITS_PER_LINE = 16
    _DEFAULT_MEM_SIZE = 64 * 1024
    _DEFAULT_MEM_BOT = 0
    _MAX_BUFFER_SIZE = 16 * 1024 * 1024

    def  __init__ ( self, memory_image_size=_DEFAULT_MEM_SIZE, \
                        memory_image_start=_DEFAULT_MEM_BOT ) :
        """
        Initialize the instance variables including the memory_image 
        to the required size.
        """

        self.error_message = [] 
        self.memory_image_size = memory_image_size
        self.memory_image_start = memory_image_start
        self.memory_image = [ (0,False) ] * self.memory_image_size


    # -----------------------------------------------------------------
    # Methods to operate on data using the application's addressing 
    # (will usually be best to use these rather than accessing the 
    # memory_image directly if the memory_image_start address is non-
    # zero). 
    # -----------------------------------------------------------------
    def validate_address( self, address ) :
        """
        Check if an address falls within the range of the internal
        buffer, and if not extend the buffer to include that address,
        adjusting the memory_image_start and memory_image_size variables.
        
        Returns True so long as the size of the buffer does not exceed
        _MAX_BUFFER_SIZE (which is very big indeed).
        """
        success = True
        if (address < self.memory_image_start) :            
            diff = self.memory_image_start - address
            if ( diff + self.memory_image_size  > Hex2Bin._MAX_BUFFER_SIZE ) :
                success = False
            else :
                self.memory_image[:0] = [(0,False)] * diff
                self.memory_image_start = address;
                self.memory_image_size = len(self.memory_image)
        elif (address >= self.memory_image_start + self.memory_image_size) :
            diff = address - (self.memory_image_start + self.memory_image_size-1)
            if ( diff + self.memory_image_size  > Hex2Bin._MAX_BUFFER_SIZE ) :
                success = False
            else :
                self.memory_image.extend( [(0,False)] * diff )
                self.memory_image_size = len(self.memory_image)
        return success

    def read_byte(self, address) :
        """
        Read a byte from the internal memory, returning a (data,valid) tuple.
        """
        if self.validate_address(address) :
            address = address - self.memory_image_start
            result = self.memory_image[address]
        else :
            result = (0xFF, False)
        return result

    def verify_byte(self, address, data) :
        """
        Returns True for verified byte, False for failure
        """
        result = False
        if self.validate_address(address) :
            address = address - self.memory_image_start
            if ( self.memory_image[address] == data ) :
                result = True            
        return result

    def write_byte(self, address, data) :
        """
        Write the data to the internal memory.
        """
        if self.validate_address(address) :
            address = (address - self.memory_image_start)
            self.memory_image[address] = ( data, True )

    def invalidate_byte(self, address) :
        """
        Reset the valid flag at the given address and zero the data.
        """
        if self.validate_address(address) :
            address = (address - self.memory_image_start)
            self.memory_image[address] = ( 0, False )

    # ------------------------------------------------------------------------    
    # Basic IO routines to load the memory_image or write its contents to disk
    # ------------------------------------------------------------------------
    def write_hex_file( self, filename, first_address=_DEFAULT_MEM_BOT, 
                        number_of_bytes=_DEFAULT_MEM_SIZE, 
                        hex_bytes_per_line=_HEX_DIGITS_PER_LINE) :
        """
        Write the selected area of internal memory to a file in a generic 
        ASCII Hex format.
        """
        success = True
        self.error_message = []
        try :
            f = open(filename,'w')

            # Build a list of hex digits first
            hex_list = []
            for i in range( first_address, first_address+number_of_bytes ) :
                (c, valid) = self.read_byte(i)            
                hex_list.append("%02x " % c)

                # Write the file buffer when it's full or if we reached the end 
                # of the data
                if ( (len(hex_list)==hex_bytes_per_line) or 
                     (i == (first_address+number_of_bytes-1)))  :
                    hex_list.append("\n")
                    f.write(''.join( hex_list ))
                    hex_list = []

            f.close()
        except :
            self.error_message.append(
                "write_hex_file error - problem writing file \"%s\" "
                % filename)
            success = False            
        return success

    def write_intel_hex_file( self, filename, first_address=_DEFAULT_MEM_BOT, 
                              number_of_bytes=_DEFAULT_MEM_SIZE, 
                              ignore_valid_flag=False, 
                              hex_bytes_per_line=_HEX_DIGITS_PER_LINE) :
        """
        Write the selected area of memory to a file in Intex Hex format.
        Only bytes where the valid flag is true are written in this format,
        unless the 'ignore_valid_flag' parameter is True.
        """
        success = True
        self.error_message = [] 
        try :
            f = open(filename,'w')

            record_type = 0
            hex_list = []
            data_bytes = []
            # Add characters to the file buffer first
            for i in range( first_address, first_address+number_of_bytes ) :
                (c, valid )  = self.read_byte( i )
                valid |= ignore_valid_flag
                if valid :
                    # Reset the address and checksum if we haven't accumulated 
                    # any (valid) data bytes yet
                    if len(data_bytes) == 0 :
                        address = i

                    hex_list.append( "%02X" % c )
                    data_bytes.append(c)
                # Write the file buffer when it's full or if we reached the 
                # end of the data or if we encounter invalid data ending
                # a run of valid data
                if ( len(hex_list) == hex_bytes_per_line or \
                         i ==  (first_address+number_of_bytes-1) or valid == False ) :
                    if ( len (hex_list) > 0 ) :
                        checksum = self.calculate_ihex_checksum( address, 
                                                                 record_type, 
                                                                 data_bytes )
                        f.write( ":%02X%04X%02X%s%02X\n" % 
                                 (len(data_bytes), address, record_type, 
                                  ''.join( hex_list ), checksum ))
                        hex_list = []
                        data_bytes = []

            # Write an eof record now
            f.write( ":00000001FF\n")
            f.close()
        except:
            self.error_message.append(
                "write_intel_hex_file error - problem writing file \"%s\" "
                % filename )
            success = False

        return success


    def write_binary_file(self, filename, first_address=_DEFAULT_MEM_BOT, 
                          number_of_bytes=_DEFAULT_MEM_SIZE):
        """
        Write the selected area of memory to a file in simple binary format.
        """
        success = True
        self.error_message = []
        try :                
            f = open(filename,'wb')
            bytes = bytearray()
            for i in range( first_address, first_address+number_of_bytes ) :
                (c, valid )  = self.read_byte( i )
                bytes.append( c & 0xFF)
            f.write( bytes )
            f.close()
        except :
            self.error_message.append(
                "write_binary_file error - problem writing file \"%s\" "
                % filename)
            success = False
        return success

    # --------------------------------------------------------------
    # Methods to read data from files and load up the internal memory.
    # --------------------------------------------------------------

    def read_intel_hex_file(self, filename, ignore_checksum=False):
        """
        Parse an Intel Hex file and store the data into the internal 
        memory image.
        
        If the file is read successfully the routine returns 'True', 
        otherwise any file errors will result in the routine aborting
        and returning 'False'. In the latter case, the image will have been 
        updated with new data prior to the file error.
        
        In the event of a fail, the instance variable self.error_message can 
        be queried for all errors detected in the file.
        
        Currently handles record types 0, 1 and 4 correctly. Other record 
        types are parsed but not necessarily used.
        """
      
        self.error_message = [] 

        try :
            f = open(filename, 'r')

            # Create a simple regexp to match against each line, which is
            # basically a colon followed by at least 10 hex digits, and 
            # nothing other than hex digits allowed in the rest of the line

            ihex_line_regex = re.compile("^:([0-9]|[a-f]){9,128}?([0-9]|[a-f])*$", 
                                         re.IGNORECASE)
            line_num = 0
            low_address = 0
            high_address = 0

            for l in f :
                l = l.strip()
                line_num += 1
                if ihex_line_regex.match(l) :
                    hex_digit_pairs = re.findall( "(..)", l[1:])                  
                    bytes_in_line = int(hex_digit_pairs[0], 16)
                    low_address = int(hex_digit_pairs[1] + hex_digit_pairs[2], 16)
                    record_type = int(hex_digit_pairs[3], 16)
                    checksum = int(hex_digit_pairs[-1], 16)

                    data_bytes = []
                    for c in hex_digit_pairs[4:-1] :
                        data_bytes.append( int(c, 16))

                    if  len(data_bytes) != bytes_in_line :
                        self.error_message.append(
                            "read_intel_hex_file error - line appears wrong length for number of data bytes %d => %s" 
                            % (line_num,l) )
                        break

                    if ignore_checksum == False :
                        calculated_chksum = self.calculate_ihex_checksum( low_address, 
                                                                          record_type, 
                                                                          data_bytes )          
                        if checksum != calculated_chksum :
                            print("crapola")
                            self.error_message.append( 
                                "read_intel_hex_file error - checksum (%02x) doesn't match calculated value (%02x) on line %d => %s" 
                                % (checksum, calculated_chksum, line_num, l) )
                            break

                    if record_type == 0 :    ## Standard data record
                        full_address =  (low_address + high_address ) 
                        for c in data_bytes :
                            self.write_byte(full_address, c )
                            full_address = (full_address + 1) 

                    elif record_type == 1 :  ## EOF Record
                        if low_address != 0 or bytes_in_line != 0  :
                            self.error_message.append(  
                                "read_intel_hex_file error - error in EOF record on line %d => %s" 
                                % (line_num,l) )
                            break
                    elif record_type == 2 :  ## Extended Segment addressing
                        if low_address != 0 or bytes_in_line != 2  :
                            self.error_message.append(  
                                "read_intel_hex_file error - error in Extended Segment record on line %d => %s" 
                                % (line_num,l) )
                            break
                        high_address = (int(hex_digit_pairs[4] + hex_digit_pairs[5], 16) << 4) & 0x0000F0000
                    elif record_type == 4 :  ## Extended linear address record
                        if low_address != 0 or bytes_in_line != 2  :
                            self.error_message.append(
                                "read_intel_hex_file error - error in Extended Segment record on line %d => %s" 
                                % (line_num,l) )
                            break
                        high_address = (int(hex_digit_pairs[4] + hex_digit_pairs[5], 16) << 16) & 0xFFFF0000   
                else :
                    self.error_message.append(
                        "read_intel_hex_file error - bad characters on line %d => %s" 
                        % (line_num,l) )
                    break
            f.close()
        except :
            self.error_message.append(
                "read_intel_hex_file error - problem reading file \"%s\" "
                % filename )
        return ( len(self.error_message) == 0 )


    def calculate_ihex_checksum( self, address, record_type, byte_list ) :
        """
        Returns the Intel Hex Checksum for a line of data.
        """
        return  ( - ( ((address >> 8) & 0xFF) + 
                      (address & 0xFF) + record_type + len(byte_list) + sum(byte_list) ) 
                    ) & 0xFF


    def read_file( self, filename, oformat="ihex", address=_DEFAULT_MEM_BOT, 
                   size=_DEFAULT_MEM_SIZE,
                   ignore_checksum=False) :
        """
        Wrapper function calls the appropriate read_<format>_file function and
        returns True if the file was read successfully, False otherwise.
        """
        self.error_message = []
        result = False
        if oformat == "ihex" :
            result = self.read_intel_hex_file(filename, ignore_checksum) 
        elif oformat == "binary" or oformat == "bin" :
            result = self.read_binary_file(filename, address) 
        elif oformat== "hex" :
            result = self.read_hex_file(filename, address)        
        else :
            self.error_message.append(
                "Unrecognized file format %s - use ihex, hex or bin(ary) only" 
                % oformat)
        return result
        
    def write_file( self, filename, oformat, 
                    first_address=_DEFAULT_MEM_BOT, 
                    number_of_bytes=_DEFAULT_MEM_SIZE, 
                    ihex_ignore_valid_flag=False, 
                    hex_bytes_per_line=_HEX_DIGITS_PER_LINE ) :
        """
        Wrapper function calls the appropriate write_<format>_file function and
        returns True if the file was written successfully, false otherwise.
        """
        self.error_message = []
        result = False
        if oformat == "ihex" :
            result = self.write_intel_hex_file(filename, first_address, 
                                               number_of_bytes, 
                                               ihex_ignore_valid_flag, 
                                               hex_bytes_per_line ) 
        elif oformat == "binary" or oformat == "bin" :
            result = self.write_binary_file(filename, first_address, 
                                            number_of_bytes) 
        elif oformat== "hex" :
            result = self.write_hex_file(filename, first_address, 
                                         number_of_bytes, 
                                         hex_bytes_per_line)                
        else :
            self.error_message.append("Unrecognized file format %s - use ihex, hex or bin(ary) only" % oformat)
        return result




    def read_binary_file( self, filename, address=0 ) :
        """
        Read the contents of a binary file into the memory image starting 
        at the given address
        """
        self.error_message = []  
        try :
            addr = address
            f = open( filename, "rb")
            while 1 :                
                s = f.read(4096)
                if s == "" :
                    break                
                for c in s :
                    self.write_byte(addr, ord(c) )
                    addr += 1            
            f.close()            
        except EOFError:
            # ok to get an early EOF because we don't know how long the 
            # file is
            pass
        except :
            self.error_message.append(
                "read_bin_file error- problem reading file \"%s\" "
                % filename )            
        return  ( len(self.error_message) == 0 )


    def read_hex_file(self, filename, start_adr=_DEFAULT_MEM_BOT) :
        """
        Read a number of bytes from the given hex file into internal 
        memory starting at start_adr. 
        
        Returns True if file is read successfully
        """
        self.error_message = []  
        adr = start_adr
        hex_re = re.compile('[0-9,A-F][0-9,A-F]', re.IGNORECASE )
        try :
            f = open(filename)
            for l in f :
                for byte in  hex_re.findall(l) :
                    self.write_byte( adr, int(byte, 16))
                    adr += 1
            f.close()
        except:
            self.error_message.append(
                "read_hex_file error- problem reading file \"%s\" "
                % filename)           
        return(len(self.error_message)==0)


# Add static functions here to allow use for converting between different formats
def usage() :
    """
    Display usage message and exit.
    """
    usage_string = """
  USAGE:

    hex2bin.py is intended to perform basic file IO for CPU development 
    tools, but can also be run standalone to convert between various
    popular data formats.

  REQUIRED SWITCHES:

    -i --format_in  <hex|bin|ihex>   format of input data file
    -o --format_out <hex|bin|ihex>   format of output data file
    -f --file_in <filename>          name of input data file
    -g --file_out <filename>         name of output data file

  OPTIONAL SWITCHES:
    
    -k --file_in2 <filename>         name of second input data file
    -b --buffer_size                 initial size of internal memory image
    -c --input_start_adr             address of first byte in input file
    -e --output_start_adr            first address to write to output file
    -d --output_num_bytes            number of bytes to write to output file
    -h --help                        print this usage message
    -j --ignore_checksum             ignore checksum data in input files
    -u --write_uninitialized_memory  write all locations in the specified range
    -q --difference                  write out only differences between the
                                     two input files provided

    The -b --buffer_size option specifies the size of the internal memory buffer
    on starting up. If the data being read falls outside the buffer size then
    the buffer will expand automatically up to a maximum size of 16MB. This option
    will make reading particularly large files slightly more efficient if a
    sufficiently large sized buffer is specified to begin with, rather than having
    to expand the buffer byte by byte as new data is read in.

    The -c --input_start_adr option specifies the location in memory to place the
    first data byte from the input file, otherwise the default is to begin at 
    address 0. This option is ignored when using data files which embed address
    information with the data, e.g. Intel Hex or Motorola SREC formats.

    The -i --ignore_checksum option allows data files with built-in checksums 
    (Intel Hex, SREC) to be read ignoring bad checksum values, which would
    otherwise cause the program to print an error message and stop. This is
    just to allow use of old data files in IHEX format which have a fixed
    '00' encoded at the end of each line instead of a valid checksum.

    The -u --write_uninitialized_memory option forces all locations in the
    given range to be written out. This is the default (and only) behaviour
    possible for simple binary and hex formats, but formats which include
    address information with the data would normally write out only valid
    bytes, i.e. bytes which were assigned during the file read process.
    Using this option Intel Hex and SREC files will have contiguous data
    written out for the memory range with arbitrary data in the uninitial-
    -ized memory locations.

    The -q --difference option requires the user to specify two input files.
    These two files are compared and only the differences are written to the 
    output file. Any file formats can be used for the input files, although 
    both files must be in the same format. One of the hex output formats
    including addresses with the data, for example Intel hex or SREC formats,
    should be used for the result file since these are the only formats 
    able to represent non-contiguous bytes.

  EXAMPLES:

    python -i ihex -o ihex -f sample.ihex -g sample_out.ihex \\
           --ignore_checksum

    Fix checksums in an Intel Hex file. There is no need to specify
    either input or output address ranges in this case. Reading the IHEX
    file, all address information is embedded with the data. By default
    writing to an IHEX file writes only the data which was assigned
    during the reading in process.

    python -i bin -o ihex -f sample.bin -g sample_out.ihex \\
           --input_start_adr 0xF000 \\
           --output_start_adr 0xFF00 \\
           --output_num_bytes 0x100

    Read a binary image into the memory area starting at 0xF000, then
    write out an IHEX file of data in the range 0xFF00-0xFFFF.
    """
    print(usage_string)
    sys.exit(0)


def main(argv) :
    """
    Command line option parsing.
    """
    file_in = ""
    file_in2 = ""
    file_out = ""
    format_in = "ihex"
    format_out = "ihex"
    ignore_checksum = False
    write_uninitialized_memory = False
    input_start_adr = Hex2Bin._DEFAULT_MEM_BOT
    buffer_size = Hex2Bin._DEFAULT_MEM_SIZE
    output_start_adr = -1
    output_num_bytes = 0
    difference = False

    try:
        opts, args = getopt.getopt( argv[1:], "i:o:f:g:k:b:c:e:d:hjqu",
                                    ["format_in=","format_out=",
                                     "file_in=","file_out=", 
                                     "file_in2=",
                                     "buffer_size=",
                                     "input_start_adr=",
                                     "output_start_adr=",
                                     "output_num_bytes=",
                                     "help", "ignore_checksum",
                                     "difference",
                                     "write_uninitialized_memory"])
    except getopt.GetoptError as err:
        print(str(err))
        usage()
    
    for opt, arg in opts :
        if opt in ("-i", "--format_in") :
            format_in = arg
        elif opt in ("-o", "--format_out") :
            format_out = arg
        elif opt in ("-f", "--file_in") :
            file_in = arg
        elif opt in ("-k", "--file_in2") :
            file_in2 = arg            
        elif opt in ("-g", "--file_out") :
            file_out = arg
        elif opt in ("-b", "--buffer_size") :
            buffer_size = int(arg,0)
        elif opt in ("-c", "--input_start_adr") :
            input_start_adr = int(arg,0)
        elif opt in ("-d", "--output_num_bytes") :
            output_num_bytes = int(arg,0)
        elif opt in ("-e", "--output_start_adr") :
            output_start_adr = int(arg,0)
        elif opt in ("-h", "--help") :
            usage()
        elif opt in ("-j", "--ignore_checksum") :
            ignore_checksum = True
        elif opt in ("-q", "--difference") :
            difference = True
        elif opt in ("-u", "--write_uninitialized_memory") :
            write_uninitialized_memory = True
        else :
            usage

    rslt = False
    if ( file_in != "" ) :
        h = Hex2Bin(memory_image_start=input_start_adr, 
                     memory_image_size=buffer_size)
        rslt = h.read_file( file_in, format_in, input_start_adr, 
                            ignore_checksum=ignore_checksum)
    if ( file_in2 != "" and difference ) :
        h2 = Hex2Bin(memory_image_start=input_start_adr, 
                     memory_image_size=buffer_size)
        rslt2 = h2.read_file( file_in2, format_in, input_start_adr, 
                             ignore_checksum=ignore_checksum)

        # Invalidate all bytes which are identical between file1 and file2 
        # when in difference mode
        for adr in range(input_start_adr, input_start_adr+buffer_size ) :
            if h2.read_byte(adr)[0] == h.read_byte(adr)[0]:
                h.invalidate_byte(adr)
                
    if rslt :
        if output_start_adr < 0 :
            output_start_adr = 0
        if output_num_bytes == 0 :
            output_num_bytes = h.memory_image_start + h.memory_image_size

        rslt = h.write_file(file_out, format_out, output_start_adr,
                            output_num_bytes, 
                            ihex_ignore_valid_flag=write_uninitialized_memory)
    if ( not rslt ) :
        print("Problem reading in file %s" % file_in)
        for e in h.error_message :
            print(e)



if __name__ == "__main__" :
    main(sys.argv)
    sys.exit(0)

