OBJS=\
	vtk_t.o  
comp = gfortran
output_file = test.vtu
#output_file = output/blockBefore/blockBefore.pvts
#output_file = output/in_out/in_out.pvts
#flags=-Wall -Wextra -Wconversion -fcheck='all' -ffixed-line-length-none -fdefault-real-8 -g -O3 -DMPI2 -J./Lib_VTK_IO/mod/
flags=-Wall -Wextra -Wconversion -fcheck='all' -ffixed-line-length-none -fdefault-real-8 -O3 -DMPI2 -J./Lib_VTK_IO/mod/
# -Wall gives Write out of ALL flags (warnings)
#  -Wextra same as above, but for more warnings
#  -Wconversion not too sure what this does...
#  fcheck='all' checks all fortran checking (includes out of bounds array indices
#  -fdefault-real-8 makes double precision
#  -ffixed-line-length-none  not too sure what this does...
#  -O3 optimization
#  -J where to see and put mod files
namelist = input.namelist
name = vtk_t

all: compile run 

VTK:
	cd Lib_VTK_IO; make

compile: VTK $(OBJS)
	$(comp) ./Lib_VTK_IO/obj/*.o *.o $(flags) -o $(name).exec

run: 
	$(name).exec 

clean: 
	rm -f *.mod
	rm -f *.exec 
	rm -f *.o
	rm -f *.txt
	rm -rf output

paraview:
	paraview $(output_file) &

.SUFFIXES:
.SUFFIXES: .f90 .o
.f90.o:
	$(comp) $< $(flags) -c -o $@
