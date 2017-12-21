#!/bin/bash
set -x -e

cmake -G "Visual Studio 15 2017 Win64" \
      -DBUILD_ENET:BOOL="0" \
      -DUSE_GRAPHICAL_BENCHMARK:BOOL="0" \
      -DUSE_MSVC_RUNTIME_LIBRARY_DLL:BOOL="1" \
      -DBUILD_CLSOCKET:BOOL="0" \
      -DBUILD_UNIT_TESTS:BOOL="0" \
      -DBUILD_BULLET2_DEMOS:BOOL="0" \
      -DBUILD_BULLET3:BOOL="0" \
      -DBUILD_OPENGL3_DEMOS:BOOL="0" \
      -DUSE_GLUT:BOOL="0" \
      -DBUILD_EXTRAS:BOOL="0" \
      -H. -Bbuild

cmake --build build --config RelWithDebInfo -- /maxcpucount

mkdir -p lib64
for f in BulletCollision BulletDynamics LinearMath BulletSoftBody BulletInverseDynamics; do
  mv build/lib/RelWithDebInfo/${f}_RelWithDebugInfo.lib lib64/${f}.lib
done
find build/src/ -name '*.pdb' -exec mv {} lib64 \;

rm -rf build
