@rem generate OpenJPEG release on Windows

@rem get tmpdir:
TMPDIR=%TMP%\openjpeg_release

@rem use VCExpress 2005 for portability
call "%VS80COMNTOOLS%vsvars32.bat"

SET LIB=C:\Program Files\Microsoft SDKs\Windows\v7.0\Lib;%LIB%
SET INCLUDE=C:\Program Files\Microsoft SDKs\Windows\v7.0\Include;%INCLUDE%

mkdir %TMPDIR%
cd %TMPDIR%
svn checkout http://openjpeg.googlecode.com/svn/branches/openjpeg-1.5 openjpeg

mkdir %TMPDIR%\openjpeg-build
cd %TMPDIR%\openjpeg-build
cmake -G "NMake Makefiles" ..\openjpeg > config.log 2>&1

@rem build gdcm
nmake > nmake.log 2>&1

@rem create NSIS installer
cpack -G NSIS > nsis.log 2>&1

@rem create binary zip
cpack -G ZIP > zip.log 2>&1

@rem create source zip
cpack -G ZIP --config CPackSourceConfig.cmake szip.log 2>&1