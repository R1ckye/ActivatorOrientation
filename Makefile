include theos/makefiles/common.mk

TWEAK_NAME = ActivatorOrientation
ActivatorOrientation_FILES = ActivatorOrientation.m
ActivatorOrientation_LDFLAGS = -lactivator -Llib/
ActivatorOrientation_FRAMEWORKS = Foundation

include theos/makefiles/tweak.mk
