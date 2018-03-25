==================
The F100-L Project
==================

Welcome to the F100-L Project.

The aim of this project is to preserve a little knowledge and understanding of an
all but forgotten microprocessor, the Ferranti F100-L. This was a full 16 bit
microprocessor implemented in bipolar technology and introduced in 1976. When
it was announced it was indeed a technological marvel but it never achieved lasting
fame since its use was confined almost exclusively to the military
market in the UK. Even so, this processor and a successor F200-L remained in
production right up until the early 1990s. That's a pretty good innings for an
little known CPU.

The documentation here provides a brief introduction to the life and times of the CPU
and collects pointers to a number of external resources. Unfortunately
many of these are not freely available on the web; the best technical reference
papers are all behind paywalls, and the Ferranti F100-L Hardware Manual seems to be
physically available only in The British Library. So, a key aim of the F100-L
project documentation is to provide sufficient technical information on the
CPU architecture and the instruction set to at least allow the creation of a
software emulation of the CPU.

We have not been able to find any snippets of F100-L code on the web, but from
the Hardware Manual and other references have created an assembler and a simple
CPU emulator. Both of these are written in Python and share a lot of code in an
object oriented style. Much of the technical documentation has been
auto-generated from this code, using Sphinx_ , but a negative consequence of this particular
OO coding style is that the emulator is not spectacularly fast. That's not important
for this initial sketch though as it is really intended only to be correct
and to act as a reference for a better implementation, possibly in C or JavaScript later.

The project is a work in progress and likely to move very slowly as time allows. At the
moment the emulator and assembler are both still being completed and tested. A disassembler
will be added into the same Python code shortly and then the focus will be to add accurate instruction
timings to the emulator so that we can begin to write short snippets of code and benchmark the
processor again some of its contemporaries from the late 1970s.

Eventually we would like to look at some of the following ideas:

* implementation of a better, more accessible emulator

  * possibly in Javascript with a graphical front-panel
  * possibly in C to be used with the PiTubeDirect_ project and a BBC Micro

* implementation of a higher high level language to allow larger programs to be run

  * possibly an extension of the Cminusminus_ teaching code
  * possibly a 16bit BCPL OCODE/CINTCODE interpreter

* re-implementation of the CPU in hardware in a CPLD or FPGA, mainly to evaluate the trade-offs of performance against the resource saving choice of a bit-serial datapath architecture

More ambitiously, a full reverse engineering of the F100-L netlist or at least one or more
of the associated chips is also a long-term possibility: something along the lines of the Visual6502_
project. For this part of the project, some high resolution die photography has already been done both of the CPU
itself and some of the associated peripheral chips. These photos are available on my photo hosting website_ .

.. _Sphinx: http://www.sphinx-doc.org/en/1.5
.. _Visual6502: http://visual6502.org
.. _Cminusminus: https://github.com/revaldinho/c--
.. _PiTubeDirect: https://github.com/hoglet67/PiTubeDirect
.. _website: https://revaldinho.smugmug.com/Vintage-Technology/Integrated-Circuits/Ferranti-F100-and-Related-ICs

And finally, the F100-L and family chips really should have a wikipedia article, shouldn't they?

Revaldinho. December 2016
