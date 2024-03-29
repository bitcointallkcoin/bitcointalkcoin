# Based on: http://code.google.com/p/ostinato/source/browse/protobuf.pri
#
# Qt qmake integration with Google Protocol Buffers compiler protoc
#
# To compile protocol buffers with qt qmake, specify PROTOS variable and
# include this file
#
# Example:
# PROTOS = a.proto b.proto
# include(protobuf.pri)
#
# Set PROTO_PATH if you need to set the protoc --proto_path search path
# Set PROTOC to the path to the protoc compiler if it is not in your $PATH
#

isEmpty(PROTO_DIR):PROTO_DIR = .

isEmpty(PROTOC):PROTOC = $$PWD/depends/armv7a-linux-android/native/bin/protoc


PROTOPATHS =
for(p, PROTO_PATH):PROTOPATHS += --proto_path=$${p}

message("Generating protocol buffer classes from .proto files.")

protobuf_decl.name  = protobuf header
protobuf_decl.input = PROTOS
protobuf_decl.output  = ${QMAKE_FILE_IN_PATH}/${QMAKE_FILE_BASE}.pb.h

protobuf_decl.commands = $$PWD/depends/armv7a-linux-android/native/bin/protoc --cpp_out=${QMAKE_FILE_IN_PATH} --proto_path=${QMAKE_FILE_IN_PATH} ${QMAKE_FILE_NAME}

protobuf_decl.variable_out = HEADERS
QMAKE_EXTRA_COMPILERS += protobuf_decl

protobuf_impl.name  = protobuf sources
protobuf_impl.input = PROTOS
protobuf_impl.output  = ${QMAKE_FILE_IN_PATH}/${QMAKE_FILE_BASE}.pb.cc
protobuf_impl.depends  = ${QMAKE_FILE_IN_PATH}/${QMAKE_FILE_BASE}.pb.h
protobuf_impl.commands = $$escape_expand(\\n)
protobuf_impl.variable_out = SOURCES
QMAKE_EXTRA_COMPILERS += protobuf_impl
