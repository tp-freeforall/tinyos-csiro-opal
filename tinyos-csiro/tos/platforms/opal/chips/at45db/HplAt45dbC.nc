/*
* Copyright (c) 2006, Technische Universitat Berlin
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions
* are met:
* - Redistributions of source code must retain the above copyright notice,
*   this list of conditions and the following disclaimer.
* - Redistributions in binary form must reproduce the above copyright
*   notice, this list of conditions and the following disclaimer in the
*   documentation and/or other materials provided with the distribution.
* - Neither the name of the Technische Universitat Berlin nor the names
*   of its contributors may be used to endorse or promote products derived
*   from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
* OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
* TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
* OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
* OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
* USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

configuration HplAt45dbC {
  provides interface HplAt45db;
}
implementation {

  components new HplAt45dbByteC(9),
	new Sam3Spi3C() as SpiC,
	HplAt45dbP,
	HplSam3uGeneralIOC;

  HplAt45db = HplAt45dbByteC;

  HplAt45dbByteC.Resource -> SpiC;
  HplAt45dbByteC.FlashSpi -> SpiC;
  HplAt45dbByteC.HplAt45dbByte -> HplAt45dbP;

  HplAt45dbP.Select -> HplSam3uGeneralIOC.PioC5;
  HplAt45dbP.FlashSpi -> SpiC;
  
  components At45dbSpiConfigC as FlashSpiConfigC;
  FlashSpiConfigC.Init <- SpiC;
  FlashSpiConfigC.ResourceConfigure <- SpiC;
  FlashSpiConfigC.HplSam3SpiChipSelConfig -> SpiC;
  FlashSpiConfigC.ChipSelectPin -> HplSam3uGeneralIOC.PioC5;
}
