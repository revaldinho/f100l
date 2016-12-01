===================
The F100-L Emulator
===================

Invoking The Emulator
=====================

.. automodule:: F100Emu
   :members:

      
Notes
=====

F100Emu is very much work in progress and not all instructions can be executed yet. In particular
the only instructions which will work in the opcode class F=0 are the HALT instructions - none
of the shifting, rotating, bit set/clear or conditional jumps are implemented at all.

Example
-------

::

  python3.5 F100Emu.py -f test2.hex -g hex
  
  # -------------------------------------------------------------------------------------------
  #    _____________  ____        __       ______                __      __            
  #   / ____<  / __ \/ __ \      / /      / ____/___ ___  __  __/ /___ _/ /_____  _____
  #  / /_   / / / / / / / /_____/ /      / __/ / __ `__ \/ / / / / __ `/ __/ __ \/ ___/
  # / __/  / / /_/ / /_/ /_____/ /___   / /___/ / / / / / /_/ / / /_/ / /_/ /_/ / /    
  #/_/    /_/\____/\____/     /_____/  /_____/_/ /_/ /_/\__,_/_/\__,_/\__/\____/_/     
  #
  #
  # F 1 0 0 - L * E M U L A T O R (c) 2016 Revaldinho & BigEd
  # -------------------------------------------------------------------------------------------
  #                                   Condition Reg.
  # PC   : Memory         : Acc. OR.  I Z V S C M F  : Instruction 
  # -------------------------------------------------------------------------------------------
    0800 : C000 0000 D000 : 0000 0000 0 0 0 0 0 0 0  :
    0802 : D000 00FF A000 : 0000 0000 0 1 0 0 1 0 0  :
    0804 : A000 0001 9000 : 00FF 00FF 0 0 0 0 1 0 0  :
    0806 : 9000 0001 9000 : FF02 0001 0 0 1 1 1 0 0  :
    0808 : 9000 0001 0523 : FF03 0001 0 0 0 1 1 0 0  :
    080A : 0523 A000 0001 : FF04 0001 0 0 0 1 1 0 0  :
  CPU Halted with halt number 0x0123
  
  
  
