# -----------------------------------------------------------------------------
# Makefile - Bill White - 7/12/11
#
# Evaporative Cooling Projects for the McKinney insilico Lab
#
# -----------------------------------------------------------------------------

PROJECT_NAME = ec

# --------------------------------------------------- compile and link settings
C++C = g++

# Optimizing serial
#C++C_COMPILE_FLAGS = -Wall -ansi -pedantic -O3 -DNDEBUG
#++C_LINK_FLAGS = -lm -lgsl -lgslcblas -L./libmdr-0.2.3 \
#	-lmdr -lboost_program_options

# Debugging serial symbols and profiling information
#C++C_COMPILE_FLAGS =-Wall -Wno-deprecated -g -pg
#C++C_LINK_FLAGS = -lm -lgsl -lgslcblas -L./libmdr-0.2.3 -lmdr -pg

# Debug parallel OpenMP
C++C_COMPILE_FLAGS =-Wall -Wno-deprecated -g -fopenmp -I../afni_src \
	-Wno-long-long -I../cpprelieff -I. \
	-I/usr/local/Cellar/libxml2/2.7.8/include/libxml2 \
	-I/usr/local/include/rjungle -I/usr/local/include -DHAVE__BOOL \
	-D__NOPLUGIN__
#C++C_LINK_FLAGS = -lm -lgsl -lgslcblas -L./libmdr-0.2.3 -lmdr \
#	-lboost_program_options -lgomp \
#	-lgomp -lmri -L$(HOME)/abin -lf2c

# Optimized parallel OpenMP
#C++C_COMPILE_FLAGS =-Wall -ansi -pedantic -O3 -DNDEBUG -fopenmp \
#	-I../afni_src -Wno-long-long
C++C_LINK_FLAGS = -lm -lgsl -lgslcblas -lboost_program_options \
	-lgomp -lmri -L$(HOME)/abin -lf2c -lmdr -lxml2 \
	-L/usr/local/lib -lrjungle -lz -llr -L/usr/local/Cellar/libxml2/2.7.8/lib

# -------------------------------------------------------------------------- EC
EC_PROG_NAME = ec
EC_OBJS = EvaporativeCoolingCLI.o EvaporativeCooling.o ../cpprelieff/Dataset.o \
	../cpprelieff/DatasetInstance.o ../cpprelieff/Statistics.o \
	../cpprelieff/ArffDataset.o ../cpprelieff/PlinkDataset.o \
	../cpprelieff/PlinkRawDataset.o ../cpprelieff/PlinkBinaryDataset.o \
	../cpprelieff/DistanceMetrics.o ../cpprelieff/ChiSquared.o \
	../cpprelieff/FilesystemUtils.o ../cpprelieff/ReliefF.o

# ----------------------------------------------------------------- BUILD RULES

all: $(EC_PROG_NAME)
	@echo "$(EC_PROG_NAME) is now up to date."

$(EC_PROG_NAME): $(EC_OBJS)
	$(C++C) -o $(EC_PROG_NAME) $(EC_OBJS) $(C++C_LINK_FLAGS)

%.o: %.C
	$(C++C) -c $(C++C_COMPILE_FLAGS) $<

%.o: %.cpp
	$(C++C) -c $(C++C_COMPILE_FLAGS) $<

%.o: %.c
	$(C++C) -c $(C++C_COMPILE_FLAGS) $<

clean:
	rm -f *.o core *~

reallyclean:
	rm -f *.o core $(EC_PROG_NAME) \
	
tarball:
	rm -f *.o core $(EC_PROG_NAME)
	tar cvfpj ~/archive/$(PROJECT_NAME)_`date '+%Y%m%d'`.tar.bz2 *
