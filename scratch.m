Xsym = X-128;
vlc = jpegenc(Xsym,17);
Z = jpegdec(vlc, 17);

draw(Z)