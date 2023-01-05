# searchPasswords
Utility to find possible passwords in world-readable files on a Unix system

Utility requires bash and the GNU version of Find

Code searches all filesystems on the loca machine that are of type ext, xfs, btrfs, or mmfs for world-readable files not owned by root or daemon that have strings in them matching a password complexity regex.  

This tool will generate a lot of false positives, but it's a start.

This code is being released as public domain.
