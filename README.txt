This is GF-Complete, Revision 1.03.   January 1, 2015.

**NOTE:** This is a [clone from GitHub](https://github.com/ceph/gf-complete)
which was adapted to cleanly compile on Windows. For that we created a
CMake based build system and implemented `bzero()` (which doesn't exist on windows)
as a wrapper around `memset()` (see *include/gf_int.h*)

Authors: James S. Plank (University of Tennessee)
         Ethan L. Miller (UC Santa Cruz)
         Kevin M. Greenan (Box)
         Benjamin A. Arnold (University of Tennessee)
         John A. Burnum (University of Tennessee)
         Adam W. Disney (University of Tennessee,
         Allen C. McBride (University of Tennessee)

The user's manual is in the file Manual.pdf.  

The online home for GF-Complete is:

  - http://jerasure.org/jerasure/gf-complete

To compile, do:

   ./configure
   make
   sudo make install
