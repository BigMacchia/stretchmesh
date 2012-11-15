##linux makefile altered from Mac version
## Makefile cribbed from the Bullet Physics makefile found here:
## http://bulletphysics.org/Bullet/phpBB3/viewtopic.php?t=7783

MAYA_LOCATION=/usr/autodesk/maya2013-x64/

## MAYA_LOCATION is the Maya installation directory. It should be already defined in your
# environment variables. If not, please change it to the appropriate directory
MAYA=$(MAYA_LOCATION)

## Change this if you want to change the name of the final plugin 
LIBRARY=stretchMesh2012.so

##################################

CPP = g++
LD = ld

CPPFLAGS = -DLINUX -D_BOOL -DINCLUDE_IOSTREAM  -fPIC \
		-fno-strict-aliasing -DREQUIRE_IOSTREAM -Wno-deprecated -Wall \
		-Wno-multichar -Wno-comment -Wno-sign-compare -funsigned-char \
		-Wno-reorder -fno-gnu-keywords -ftemplate-depth-25 -pthread \
		-Wno-deprecated -fno-gnu-keywords -g

#LDFLAGS =-bundle -ldl -shared
LDFLAGS = -ldl -shared

#GL_LIB=-framework OpenGL

MAYA_INCLUDE=-I$(MAYA)/include
MAYA_LIB=-L$(MAYA)/lib -lOpenMayaUI -lOpenMaya -lOpenMayaRender -lOpenMayaAnim -lFoundation

SOURCES = curveColliderLocator.cpp stretchMeshCmd.cpp pluginMain.cpp stretchMeshDeformer.cpp

HEADERS = CRSpline.h ksUtils.h stretchMeshDeformer.h IncludeMFnPluginClass.h stretchMeshCmd.h curveColliderLocator.h stretchMeshConsts.h


INCLUDE_FLAGS= $(MAYA_INCLUDE)
LIB_FLAGS= $(MAYA_LIB) 

OBJECTS=$(SOURCES:.cpp=.o)

all: $(SOURCES) $(LIBRARY)

.cpp.o: $(SOURCES) $(HEADERS)
	$(CPP) -c $< $(CPPFLAGS) $(INCLUDE_FLAGS) -o $@ 

$(OBJECTS): $(HEADERS)

$(LIBRARY): $(OBJECTS) 
	$(CPP) $(OBJECTS) $(LDFLAGS) $(LIB_FLAGS) -o $@

clean:
	rm -f *.o *.so

