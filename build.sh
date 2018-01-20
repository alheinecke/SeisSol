#!/bin/bash

echo "Building SeisSol variants"
ARCHS="dhsw dknl dskx"
ORDERS="6"
TOOLS="intel"

if [ $# -eq 3 ]
then
  ARCHS=$1
  ORDERS=$2
  TOOLS=$3
fi

date

T="$(date +%s)"

rm -rf bin
mkdir -p bin

for ORDER in $ORDERS
do
  for ARCH in $ARCHS
  do
    for TOOL in $TOOLS
    do
      echo "Building SeisSol with generated Kernels for order $ORDER with support for $ARCH"
      #scons useExecutionEnvironment=yes logLevel=warning logLevel0=info parallelization=hybrid scalasca=none compileMode=release numberOfTemporalIntegrationPoints=1 arch=$ARCH compiler=$TOOL order=$ORDER generatedKernels=yes memkindDir=/swtools/memkind/latest/ memkind=yes -j 32 
      #scons useExecutionEnvironment=yes logLevel=warning logLevel0=info parallelization=hybrid scalasca=none compileMode=release numberOfTemporalIntegrationPoints=1 arch=$ARCH compiler=$TOOL order=$ORDER generatedKernels=yes memkind=yes -j 32 
      scons useExecutionEnvironment=yes logLevel=warning logLevel0=info parallelization=hybrid scalasca=none compileMode=release arch=$ARCH compiler=$TOOL order=$ORDER generatedKernels=yes -j 32 
      #scons useExecutionEnvironment=yes logLevel=warning logLevel0=info parallelization=hybrid scalasca=none compileMode=release numberOfTemporalIntegrationPoints=1 arch=$ARCH compiler=$TOOL order=$ORDER generatedKernels=yes netcdf=yes hdf5=no netcdfDir=/swtools/netcdf/netcdf-4.3.0 hdf5Dir=/swtools/hdf5/hdf5-1.8.11/ -j 32 
      #scons useExecutionEnvironment=yes logLevel=warning logLevel0=info parallelization=hybrid scalasca=none compileMode=release arch=$ARCH compiler=$TOOL order=$ORDER generatedKernels=yes memkindDir=/swtools/memkind/latest/ memkind=yes -j 32 
      #scons useExecutionEnvironment=yes logLevel=warning logLevel0=info parallelization=hybrid scalasca=none compileMode=release arch=$ARCH compiler=$TOOL order=$ORDER generatedKernels=yes -j 32 
    done
  done
done

echo ""
T="$(($(date +%s)-T))"
echo "Time in seconds: ${T}"

cd build/
for i in `ls SeisSol_*`
do
  mv ${i} ./../bin/${i}
done
cd ./../

rm -rf build/build_*/ build/SeisSol_*
