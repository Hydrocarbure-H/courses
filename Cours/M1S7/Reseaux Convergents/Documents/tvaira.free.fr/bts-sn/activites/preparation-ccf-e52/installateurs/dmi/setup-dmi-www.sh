#!/bin/sh
# This script was generated using Makeself 2.4.0
# The license covering this archive and its contents, if any, is wholly independent of the Makeself license (GPL)

ORIG_UMASK=`umask`
if test "n" = n; then
    umask 077
fi

CRCsum="4278225513"
MD5="918334c74a0a0035919af813eb488224"
SHA="0000000000000000000000000000000000000000000000000000000000000000"
TMPROOT=${TMPDIR:=/tmp}
USER_PWD="$PWD"; export USER_PWD

label="Script d'installation du Serveur Web DMI"
script="./setup-dmi-www.sh"
scriptargs=""
licensetxt=""
helpheader=''
targetdir="dmi-www"
filesizes="95282"
keep="n"
nooverwrite="n"
quiet="n"
accept="n"
nodiskspace="n"
export_conf="n"

print_cmd_arg=""
if type printf > /dev/null; then
    print_cmd="printf"
elif test -x /usr/ucb/echo; then
    print_cmd="/usr/ucb/echo"
else
    print_cmd="echo"
fi

if test -d /usr/xpg4/bin; then
    PATH=/usr/xpg4/bin:$PATH
    export PATH
fi

if test -d /usr/sfw/bin; then
    PATH=$PATH:/usr/sfw/bin
    export PATH
fi

unset CDPATH

MS_Printf()
{
    $print_cmd $print_cmd_arg "$1"
}

MS_PrintLicense()
{
  if test x"$licensetxt" != x; then
    echo "$licensetxt" | more
    if test x"$accept" != xy; then
      while true
      do
        MS_Printf "Please type y to accept, n otherwise: "
        read yn
        if test x"$yn" = xn; then
          keep=n
          eval $finish; exit 1
          break;
        elif test x"$yn" = xy; then
          break;
        fi
      done
    fi
  fi
}

MS_diskspace()
{
	(
	df -kP "$1" | tail -1 | awk '{ if ($4 ~ /%/) {print $3} else {print $4} }'
	)
}

MS_dd()
{
    blocks=`expr $3 / 1024`
    bytes=`expr $3 % 1024`
    dd if="$1" ibs=$2 skip=1 obs=1024 conv=sync 2> /dev/null | \
    { test $blocks -gt 0 && dd ibs=1024 obs=1024 count=$blocks ; \
      test $bytes  -gt 0 && dd ibs=1 obs=1024 count=$bytes ; } 2> /dev/null
}

MS_dd_Progress()
{
    if test x"$noprogress" = xy; then
        MS_dd $@
        return $?
    fi
    file="$1"
    offset=$2
    length=$3
    pos=0
    bsize=4194304
    while test $bsize -gt $length; do
        bsize=`expr $bsize / 4`
    done
    blocks=`expr $length / $bsize`
    bytes=`expr $length % $bsize`
    (
        dd ibs=$offset skip=1 2>/dev/null
        pos=`expr $pos \+ $bsize`
        MS_Printf "     0%% " 1>&2
        if test $blocks -gt 0; then
            while test $pos -le $length; do
                dd bs=$bsize count=1 2>/dev/null
                pcent=`expr $length / 100`
                pcent=`expr $pos / $pcent`
                if test $pcent -lt 100; then
                    MS_Printf "\b\b\b\b\b\b\b" 1>&2
                    if test $pcent -lt 10; then
                        MS_Printf "    $pcent%% " 1>&2
                    else
                        MS_Printf "   $pcent%% " 1>&2
                    fi
                fi
                pos=`expr $pos \+ $bsize`
            done
        fi
        if test $bytes -gt 0; then
            dd bs=$bytes count=1 2>/dev/null
        fi
        MS_Printf "\b\b\b\b\b\b\b" 1>&2
        MS_Printf " 100%%  " 1>&2
    ) < "$file"
}

MS_Help()
{
    cat << EOH >&2
${helpheader}Makeself version 2.4.0
 1) Getting help or info about $0 :
  $0 --help   Print this message
  $0 --info   Print embedded info : title, default target directory, embedded script ...
  $0 --lsm    Print embedded lsm entry (or no LSM)
  $0 --list   Print the list of files in the archive
  $0 --check  Checks integrity of the archive

 2) Running $0 :
  $0 [options] [--] [additional arguments to embedded script]
  with following options (in that order)
  --confirm             Ask before running embedded script
  --quiet		Do not print anything except error messages
  --accept              Accept the license
  --noexec              Do not run embedded script
  --keep                Do not erase target directory after running
			the embedded script
  --noprogress          Do not show the progress during the decompression
  --nox11               Do not spawn an xterm
  --nochown             Do not give the extracted files to the current user
  --nodiskspace         Do not check for available disk space
  --target dir          Extract directly to a target directory (absolute or relative)
                        This directory may undergo recursive chown (see --nochown).
  --tar arg1 [arg2 ...] Access the contents of the archive through the tar command
  --                    Following arguments will be passed to the embedded script
EOH
}

MS_Check()
{
    OLD_PATH="$PATH"
    PATH=${GUESS_MD5_PATH:-"$OLD_PATH:/bin:/usr/bin:/sbin:/usr/local/ssl/bin:/usr/local/bin:/opt/openssl/bin"}
	MD5_ARG=""
    MD5_PATH=`exec <&- 2>&-; which md5sum || command -v md5sum || type md5sum`
    test -x "$MD5_PATH" || MD5_PATH=`exec <&- 2>&-; which md5 || command -v md5 || type md5`
    test -x "$MD5_PATH" || MD5_PATH=`exec <&- 2>&-; which digest || command -v digest || type digest`
    PATH="$OLD_PATH"

    SHA_PATH=`exec <&- 2>&-; which shasum || command -v shasum || type shasum`
    test -x "$SHA_PATH" || SHA_PATH=`exec <&- 2>&-; which sha256sum || command -v sha256sum || type sha256sum`

    if test x"$quiet" = xn; then
		MS_Printf "Verifying archive integrity..."
    fi
    offset=`head -n 587 "$1" | wc -c | tr -d " "`
    verb=$2
    i=1
    for s in $filesizes
    do
		crc=`echo $CRCsum | cut -d" " -f$i`
		if test -x "$SHA_PATH"; then
			if test x"`basename $SHA_PATH`" = xshasum; then
				SHA_ARG="-a 256"
			fi
			sha=`echo $SHA | cut -d" " -f$i`
			if test x"$sha" = x0000000000000000000000000000000000000000000000000000000000000000; then
				test x"$verb" = xy && echo " $1 does not contain an embedded SHA256 checksum." >&2
			else
				shasum=`MS_dd_Progress "$1" $offset $s | eval "$SHA_PATH $SHA_ARG" | cut -b-64`;
				if test x"$shasum" != x"$sha"; then
					echo "Error in SHA256 checksums: $shasum is different from $sha" >&2
					exit 2
				else
					test x"$verb" = xy && MS_Printf " SHA256 checksums are OK." >&2
				fi
				crc="0000000000";
			fi
		fi
		if test -x "$MD5_PATH"; then
			if test x"`basename $MD5_PATH`" = xdigest; then
				MD5_ARG="-a md5"
			fi
			md5=`echo $MD5 | cut -d" " -f$i`
			if test x"$md5" = x00000000000000000000000000000000; then
				test x"$verb" = xy && echo " $1 does not contain an embedded MD5 checksum." >&2
			else
				md5sum=`MS_dd_Progress "$1" $offset $s | eval "$MD5_PATH $MD5_ARG" | cut -b-32`;
				if test x"$md5sum" != x"$md5"; then
					echo "Error in MD5 checksums: $md5sum is different from $md5" >&2
					exit 2
				else
					test x"$verb" = xy && MS_Printf " MD5 checksums are OK." >&2
				fi
				crc="0000000000"; verb=n
			fi
		fi
		if test x"$crc" = x0000000000; then
			test x"$verb" = xy && echo " $1 does not contain a CRC checksum." >&2
		else
			sum1=`MS_dd_Progress "$1" $offset $s | CMD_ENV=xpg4 cksum | awk '{print $1}'`
			if test x"$sum1" = x"$crc"; then
				test x"$verb" = xy && MS_Printf " CRC checksums are OK." >&2
			else
				echo "Error in checksums: $sum1 is different from $crc" >&2
				exit 2;
			fi
		fi
		i=`expr $i + 1`
		offset=`expr $offset + $s`
    done
    if test x"$quiet" = xn; then
		echo " All good."
    fi
}

UnTAR()
{
    if test x"$quiet" = xn; then
		tar $1vf -  2>&1 || { echo " ... Extraction failed." > /dev/tty; kill -15 $$; }
    else
		tar $1f -  2>&1 || { echo Extraction failed. > /dev/tty; kill -15 $$; }
    fi
}

finish=true
xterm_loop=
noprogress=n
nox11=n
copy=none
ownership=y
verbose=n

initargs="$@"

while true
do
    case "$1" in
    -h | --help)
	MS_Help
	exit 0
	;;
    -q | --quiet)
	quiet=y
	noprogress=y
	shift
	;;
	--accept)
	accept=y
	shift
	;;
    --info)
	echo Identification: "$label"
	echo Target directory: "$targetdir"
	echo Uncompressed size: 128 KB
	echo Compression: gzip
	echo Date of packaging: Sun Jan 13 12:18:07 CET 2019
	echo Built with Makeself version 2.4.0 on 
	echo Build command was: "./makeself.sh \\
    \"./dmi-www\" \\
    \"./setup-dmi-www.sh\" \\
    \"Script d'installation du Serveur Web DMI\" \\
    \"./setup-dmi-www.sh\""
	if test x"$script" != x; then
	    echo Script run after extraction:
	    echo "    " $script $scriptargs
	fi
	if test x"" = xcopy; then
		echo "Archive will copy itself to a temporary location"
	fi
	if test x"n" = xy; then
		echo "Root permissions required for extraction"
	fi
	if test x"n" = xy; then
	    echo "directory $targetdir is permanent"
	else
	    echo "$targetdir will be removed after extraction"
	fi
	exit 0
	;;
    --dumpconf)
	echo LABEL=\"$label\"
	echo SCRIPT=\"$script\"
	echo SCRIPTARGS=\"$scriptargs\"
	echo archdirname=\"dmi-www\"
	echo KEEP=n
	echo NOOVERWRITE=n
	echo COMPRESS=gzip
	echo filesizes=\"$filesizes\"
	echo CRCsum=\"$CRCsum\"
	echo MD5sum=\"$MD5\"
	echo OLDUSIZE=128
	echo OLDSKIP=588
	exit 0
	;;
    --lsm)
cat << EOLSM
No LSM.
EOLSM
	exit 0
	;;
    --list)
	echo Target directory: $targetdir
	offset=`head -n 587 "$0" | wc -c | tr -d " "`
	for s in $filesizes
	do
	    MS_dd "$0" $offset $s | eval "gzip -cd" | UnTAR t
	    offset=`expr $offset + $s`
	done
	exit 0
	;;
	--tar)
	offset=`head -n 587 "$0" | wc -c | tr -d " "`
	arg1="$2"
    if ! shift 2; then MS_Help; exit 1; fi
	for s in $filesizes
	do
	    MS_dd "$0" $offset $s | eval "gzip -cd" | tar "$arg1" - "$@"
	    offset=`expr $offset + $s`
	done
	exit 0
	;;
    --check)
	MS_Check "$0" y
	exit 0
	;;
    --confirm)
	verbose=y
	shift
	;;
	--noexec)
	script=""
	shift
	;;
    --keep)
	keep=y
	shift
	;;
    --target)
	keep=y
	targetdir="${2:-.}"
    if ! shift 2; then MS_Help; exit 1; fi
	;;
    --noprogress)
	noprogress=y
	shift
	;;
    --nox11)
	nox11=y
	shift
	;;
    --nochown)
	ownership=n
	shift
	;;
    --nodiskspace)
	nodiskspace=y
	shift
	;;
    --xwin)
	if test "n" = n; then
		finish="echo Press Return to close this window...; read junk"
	fi
	xterm_loop=1
	shift
	;;
    --phase2)
	copy=phase2
	shift
	;;
    --)
	shift
	break ;;
    -*)
	echo Unrecognized flag : "$1" >&2
	MS_Help
	exit 1
	;;
    *)
	break ;;
    esac
done

if test x"$quiet" = xy -a x"$verbose" = xy; then
	echo Cannot be verbose and quiet at the same time. >&2
	exit 1
fi

if test x"n" = xy -a `id -u` -ne 0; then
	echo "Administrative privileges required for this archive (use su or sudo)" >&2
	exit 1	
fi

if test x"$copy" \!= xphase2; then
    MS_PrintLicense
fi

case "$copy" in
copy)
    tmpdir="$TMPROOT"/makeself.$RANDOM.`date +"%y%m%d%H%M%S"`.$$
    mkdir "$tmpdir" || {
	echo "Could not create temporary directory $tmpdir" >&2
	exit 1
    }
    SCRIPT_COPY="$tmpdir/makeself"
    echo "Copying to a temporary location..." >&2
    cp "$0" "$SCRIPT_COPY"
    chmod +x "$SCRIPT_COPY"
    cd "$TMPROOT"
    exec "$SCRIPT_COPY" --phase2 -- $initargs
    ;;
phase2)
    finish="$finish ; rm -rf `dirname $0`"
    ;;
esac

if test x"$nox11" = xn; then
    if tty -s; then                 # Do we have a terminal?
	:
    else
        if test x"$DISPLAY" != x -a x"$xterm_loop" = x; then  # No, but do we have X?
            if xset q > /dev/null 2>&1; then # Check for valid DISPLAY variable
                GUESS_XTERMS="xterm gnome-terminal rxvt dtterm eterm Eterm xfce4-terminal lxterminal kvt konsole aterm terminology"
                for a in $GUESS_XTERMS; do
                    if type $a >/dev/null 2>&1; then
                        XTERM=$a
                        break
                    fi
                done
                chmod a+x $0 || echo Please add execution rights on $0
                if test `echo "$0" | cut -c1` = "/"; then # Spawn a terminal!
                    exec $XTERM -title "$label" -e "$0" --xwin "$initargs"
                else
                    exec $XTERM -title "$label" -e "./$0" --xwin "$initargs"
                fi
            fi
        fi
    fi
fi

if test x"$targetdir" = x.; then
    tmpdir="."
else
    if test x"$keep" = xy; then
	if test x"$nooverwrite" = xy && test -d "$targetdir"; then
            echo "Target directory $targetdir already exists, aborting." >&2
            exit 1
	fi
	if test x"$quiet" = xn; then
	    echo "Creating directory $targetdir" >&2
	fi
	tmpdir="$targetdir"
	dashp="-p"
    else
	tmpdir="$TMPROOT/selfgz$$$RANDOM"
	dashp=""
    fi
    mkdir $dashp "$tmpdir" || {
	echo 'Cannot create target directory' $tmpdir >&2
	echo 'You should try option --target dir' >&2
	eval $finish
	exit 1
    }
fi

location="`pwd`"
if test x"$SETUP_NOCHECK" != x1; then
    MS_Check "$0"
fi
offset=`head -n 587 "$0" | wc -c | tr -d " "`

if test x"$verbose" = xy; then
	MS_Printf "About to extract 128 KB in $tmpdir ... Proceed ? [Y/n] "
	read yn
	if test x"$yn" = xn; then
		eval $finish; exit 1
	fi
fi

if test x"$quiet" = xn; then
	MS_Printf "Uncompressing $label"
	
    # Decrypting with openssl will ask for password,
    # the prompt needs to start on new line
	if test x"n" = xy; then
	    echo
	fi
fi
res=3
if test x"$keep" = xn; then
    trap 'echo Signal caught, cleaning up >&2; cd $TMPROOT; /bin/rm -rf "$tmpdir"; eval $finish; exit 15' 1 2 3 15
fi

if test x"$nodiskspace" = xn; then
    leftspace=`MS_diskspace "$tmpdir"`
    if test -n "$leftspace"; then
        if test "$leftspace" -lt 128; then
            echo
            echo "Not enough space left in "`dirname $tmpdir`" ($leftspace KB) to decompress $0 (128 KB)" >&2
            echo "Use --nodiskspace option to skip this check and proceed anyway" >&2
            if test x"$keep" = xn; then
                echo "Consider setting TMPDIR to a directory with more free space."
            fi
            eval $finish; exit 1
        fi
    fi
fi

for s in $filesizes
do
    if MS_dd_Progress "$0" $offset $s | eval "gzip -cd" | ( cd "$tmpdir"; umask $ORIG_UMASK ; UnTAR xp ) 1>/dev/null; then
		if test x"$ownership" = xy; then
			(cd "$tmpdir"; chown -R `id -u` .;  chgrp -R `id -g` .)
		fi
    else
		echo >&2
		echo "Unable to decompress $0" >&2
		eval $finish; exit 1
    fi
    offset=`expr $offset + $s`
done
if test x"$quiet" = xn; then
	echo
fi

cd "$tmpdir"
res=0
if test x"$script" != x; then
    if test x"$export_conf" = x"y"; then
        MS_BUNDLE="$0"
        MS_LABEL="$label"
        MS_SCRIPT="$script"
        MS_SCRIPTARGS="$scriptargs"
        MS_ARCHDIRNAME="$archdirname"
        MS_KEEP="$KEEP"
        MS_NOOVERWRITE="$NOOVERWRITE"
        MS_COMPRESS="$COMPRESS"
        export MS_BUNDLE MS_LABEL MS_SCRIPT MS_SCRIPTARGS
        export MS_ARCHDIRNAME MS_KEEP MS_NOOVERWRITE MS_COMPRESS
    fi

    if test x"$verbose" = x"y"; then
		MS_Printf "OK to execute: $script $scriptargs $* ? [Y/n] "
		read yn
		if test x"$yn" = x -o x"$yn" = xy -o x"$yn" = xY; then
			eval "\"$script\" $scriptargs \"\$@\""; res=$?;
		fi
    else
		eval "\"$script\" $scriptargs \"\$@\""; res=$?
    fi
    if test "$res" -ne 0; then
		test x"$verbose" = xy && echo "The program '$script' returned an error code ($res)" >&2
    fi
fi
if test x"$keep" = xn; then
    cd "$TMPROOT"
    /bin/rm -rf "$tmpdir"
fi
eval $finish; exit $res
� o;\�<iw۶��Z��	�W�i��N�W'J��r�o��49��L��Ś[��VR���~ʛ�U�����y窧���0To<��?M���7�_�����������֞��=k����=h���Ϟ<����O�F� ���&���������@�\[����G��[�k��Պ��֞={ ����/��6F���D���L6�aysV�u�����"�x����p�s1g���ORq`V�@훡�`-�r�q���=����%!��F������=3����
��;����������.�E�̈́l��%���SɌ?�J?����^w0�8$W<��6��m�XQ{u��iA�5�|^�n��
-�+�«�����1$�����ow{��).� �qJi�1`���V�9X�� ��j��+gW��y���q�5C��Y��M�m�}�B;�������H)��"���!�#���еdC�1T�G�P�w;Ux��H	��IQ��at���������s�����U��1�ڥE@f�@zl�������'U{�^����O9U�����|N��\���@���"�^xMoM�-�C�$<=!ZɧXe��K^�J���j56Lg�L��	�bc;
|�!��1��
�_[�m?�o`:�����̤�K]n�Ҿ*�R�T����ct���Bl��XU��qj[�%̡zm헢�gǪd:�9����>Z��v�o�,B,d�p�ټ`���hCj�pg���_�f��n��0q��]��&$'\;D�68j��D�NMl��\�NH�L.�y��_A�r�QK�U��:U�'??_k=o��^�{��(��1IX��:rm�I�p���ħ�0���(��<{��%�XRK�1�OG�[�������+��g�����Y��E�k��4<dqh#��,�%Ù�I�4½�C���sЦ��Ql�� 	����%�4j�H,=�`a��AhG�B#�q�J!q���CO�0b�慸���
ؔxCE�YY�(
�]?��b�c�"�X炤��d�Uڳ�A��������ӎv���ki��B�*Q�FȸHP����g�O��$�_��;ڠ��<VD�2�����q�)ߊ���K��"F݉'v�H��:1o�����cs1Z����sϿ���L��p[tp'E����Ǥ���:#(*��v|i��6R3�о����V!I�UE��8�w����F�#�H�&-SQ6�R���-8��
w~�F��
&{�z	�\��E�n�J)Z������%?2��	s?]�o[��j����Q�K�<s��(w=����r�ǞZ���SX@Yt;b_ �X)�%��g�+����~�M�-У��WL:�l^,T�}�� ��^�{F�
�'ZZ/ x�|{�"[��fKa׳���+�Y>����L(|#�dj�*�>x7����;&�8������U��[��C��:B��6�1po��X�a6���������Yޠk����tu����@����.�Z��%����v�w08{������su��|��oz����
oZ6�8��^��c�Da��R�T��U�N%�ܗ\�ǥ��+���bY35�T��e��:3[ ��0L��y �Y�"䴙G�a��1;gT9���	�d���,�D4���)���̎�6�]����,�S�R]%����ŕ��t�����2�,/��e��y�B���~�����l�5*]���n}�?��y҂���0n�[E)�Vp~��*[�Jk��X��m/�V�S���s�2��|���th�`�{xO ���z%1;~T
��e���m�g�و�gpJ1��I���(6
&)�]�#���;��6�^Y!p��Bm����z
xcp�����J~Sd$�E���GFVG�X��O�^��m=
�I@
���B��O�T����YV��U��E����Иw�%^��+�uׄ�=���T�l\���e�Ż�:�SJ��D�f�2�ۥ�8f� yS�-t�1a���l��m�H0nw/��
ưy��F�­z�zu�����|�.��+vQ�~5@�E����u�> ��+q�d:�s�hQ�abD�C7b���1$k�烸�g:>a�̋m�<j|N��*�$/>e�J�ٔ���ZSq;k�Q����\�PÐ*f!�
��a�mx<�{I%v������7�QP�
C)�Y��_��ѥ�	�LX]��?��������V�j�j+qc�I �����JXD�� ��` .P�VŊ�u_A��EEkq�]q�ت����W)�?3�$����==�7sg��7w�yF�
`$����6�'�����4�h���YD'�ր7�Il�1Eg��-��(K�FP(��\��� �Pq�I���p���K_R��(��j}��H@�mP���#B+@]���8P�E*���(V	��+�K��V �� ���G8�]h�S�`�Z��H!��Vt���8h����
8�
UC�k���K�K��i`��ᚢ��a/���p
�1ЌRP"�DS	T�.���@�
�!h��H��AH1%���S�B�PK<\�}=�����s�eFCp� ܁e�E����*:
/���K����?��
I�R���)��]qub.�?�a�G�ီ��"k�8�O^^Fb6 ��!g`'���H�$|!����� r��@	� �g,��2epW�5�*�Y���ܓ�n4�A-�/J�5p��Fæ%�	��C��%2,.����J j�0D�<)�A�3���R!��qV�t��UY%��l�N���X�Z ��������?��#p��t��c2�m�����3���������\h�E�h#�,�� %�:P�&��-)� 
�#�"�E9��Ϧ��h4��%�ȹpf��D�qhQQ@��%�HH4�A��TuFEK�0�P"<w")� -�tK�fI�:�����=�@վ~�TXR$�� f�:#&�R9X���.:�D,��м!"*:R6�+O��׳(����,�,)~�=�<�q���{�ug��8���-�H����=�X��Q�f�%�L�XEUc�2�%%��'ȃedA�R��=as��e��rm"����gG�9�0�[����F�h =ݒjd��bG�+ŀ�t�*x8=0��x�m�4u��SI$oa߿�S�#�����/sKN�+{:*m����+��#E�-esT|XTr�ɘ�s%��`�$[lN�\�l%ںH�"���z������S��j�۷@%HP#h�h�FK�r��J�۵T|�AW�Z�FH���`\~+$~ �i�BȑD�t�E�Em�B��lY{bbGs
&EDű1������Y#��]')��"J]|࢈aT�Jww���+0�̩��5�?��s�_�MAO�������%<�����&������C��Ģ9��I�R�)QB'p@��J|  y�d�Fp1
�3d�R���\'��=��amhà4�L�@X&ǣ~�Z��j��D�B�j\p�6�3('�����.���!�J�҂ӡ	��^M����z����j`�y�8�I�*=zU�N;.@���Ҋ��m4"��.#n��m��s�!��O,GO*7�k�X(�� E��
Xo�p���hX4�;$]�˚
r�6tԄB�!�a|�@cZ��D�t�Q�M�I\�
���>�\�l�VC���{I��[S��B�#h�JC�ԊK�v�h*��P�X(m>(1���o�1�N��7�T7���b+�^��;"�X��
e����LȐ&�B�m?������&Q�vA�mŵ��Lv��.��D�ׇR��E<�Hۈ=uVh����!F��b�<���$Y۰� �II�6"������rD+G�3	�j�"�8��0pD�X=4 NG��~��L��dW�(_�&d�1Q+L���j�&���P�}P�6 �@�:1�	ʴ�{dg�?���S+\���́@�,I�:�k�a��mQ�Z�� �+���P�{Ҍ�6۱��m	�,��!���d�m��5x���Mu��&�P:&����z����
�!�~���fd7�G[�EF���1x�5 �����?�3r�]���$�zP��S�u\��(;�/����7�Nk����6�?����H�򒱢gHJ��\�\��	f�A�َK�6�B�/���a0�ѱN�ʹ��!�С�߰�L�����ѫ��������>9~�1�Bc.�^�;�bό���y���(ro��v�ێC�To�b���/{mXh��e¹�'�}3�n��m�I絿�͞���"#~��8�Q��aLydG��^�r�:}k��~� �ן���QRXT�"�k}<�a�4���Y��by߉�'k����l��^A�2�?����÷5=Y���y�U�� c������c%)A+���n^����E�&a�Lj� ��ҋ߱�+�8�[=��eU�[���6>`Q�~V��N]KgL��ݿ۫S�w���7��3�Ce�~=������ܸ���Sj��W�
֏���3`ɡw��yQR(��ט�[\�%��C���]^9Ƹx�9�p/��[�ϑ������w�Lo&�������XEz�fl��.����~yrCP"������mW6��X��ahN�
�z5�W)ޅ/O�B�9��Gv��\S��V/�]q���kg�Z':5��j��i[n���p�->c��̍��3�DSg�y�k���p����g��~s׷�����*��SrS_�N~Z{F���L��/fu��Jx��s&^ջP�͹YU�k�tȩ�雓V{���蚯A���D~�x��ν�����:g.�ŏ|a�[}?�m��1��ה�ˏ��j+�P=��_z򹚋ͭ�wr��X��br�䕟BU������-{)l���[��{��Nm�戼F��!s��"W�u���;�}w�v�dw����w�W������WC�-|Q��M\�۵v�u�ݜ�+#*�S�Uw�\D�OU��)�������6���Vyt\ w�5Ow���vB�3�������/｜��#�b�ꢳ��o�djW=�*
�4�����ϊ:W�otn��,�(�[u���P���v��]ی��<�����g���kV�fuޯ���[w�g��SLx���z;^8�5s���/
^�eIZ�o܁n��ѩiY�R��T�z�T��3w�Ɯy�&#X�e\[��C�g��5Ŷ&$l�d�{�'Y]�	ﶷ�<��G]\%��M����n��S���f{��7.�{�br�'>�ӗ�j�Ҋ��Hu��R��sm��*9"��Q��#|o=D�^�N�N}5���
����8�ߛ��ݷ��f|�M��Rs���Ta������ۇ!���WuiŴL��l���Z�}au^|ꄗ;�|(�4+HhW�Q�{����R�Ie�R���
��Rׄ@5ǁ��������?���?��[M"��\i�_CMs������*g��o$6�?�u�^7�2�z�{���pFJ�ӌ��;x��)0�ۢ�E���n�s[�=Ɗ��6�%&�������Ӕ,���K�h����]w�$>w�����>�5���my��J��FO΃,<gK���-�!��T�3���	�p��=�U�����Zꢔ�<'r������γN}Ϛ�}L���YCbJ�Ct��n"J�r뙖l��tO�v���>�i�[�j�߯�^�-��N��`��C���	��;V�ޚ�y(rg�ԝ�:x~D�$d�퓭�����Zkߎ��x��� �[����'�w�p/�:uC���:Ϙׂ]�3�ʖ֩�-�l����R�ٷ�F��rɂz����̦�%���o�n3�?J�8�������<�����yk����b��ަOj/�fm�D֦>A.�U��)��r�⯠���>%��3d�OH�D.����"f�[�Z�"\\zzzR�
5ޒ���N���/�0ß"ɥs��>WG���{��������2��U�.zL��}�ywߙ>����U3�b�t��n�J��l~.����m��,�31�P|��g��r}!i4U`�}�<en�m�bg7�5{	ùe�&>��{m�=������j���'{�^��^?��k�ބ/4w�B�,�?ć3��&��x
Z!*�[�nیe���-�"������D>�t{D��a�W�>�ӝ����x�0Zi7oĵk��Sm�DK����=xkJ,^�|���yEpʵ�/x��u�o��&��і���wY�:l|[l�_���"~�`�
߆��ݳ'nV���K��P.˻��;Wu��n����N�+�*O"�,�Kh	�oU)q�n=��d��'K�HL./k��u!̃/H,��95�u7��oyq�cX���I⧔�>N����)�sR4�0q�	t��s<���F�K���H�핛4�L@ݔ� ����͛DR��N�\��-�j�|��z���&U�;�<��K�׵�F�u{�MW����ȝ��l������d�i�΂=�m�↎틲��
:	R��Ʈ����y����(�|����t��6��#N�~��j}42�Ǫ�A�k�s��<�߼q]IV�N����6�>�|��!�(L�D�S6�a5Wv�"i�u�-|\8C9�S�[�k�}��Z��lׇ7E]VXYlD��f�f�f�[&�֡+0�[��g����Iù��b�S���a�#�s;�79�;r�8����bs�#���h;o����p0�(�{rTR�D�ޗ�_�?�Ѵфi��$���auW�\�C��߸���ֽ�{:�5�?������~�-'�ժ�w;�A�>�o���w��D������gg/U^��e�Z�ȩH�ȶ�**�׾��ۖo��	|�q丹|��ěǟ��3�nҾ�G�y�U4Wj\"�h~A��{D�������xH���EA-�>�ڦW)Q��{��[��U��;�uML\�j�iv��I�R������f�R�1�c�]��H��w:�5��S�S��ygߞ�y��aJ��ODi����򟵯/ڣ���7�?��H)��
^��eȖ�ٗ�Sr�H�u)Z���+�HyM��E�q�}���λ��2�re�F�o�TEA���,[�����$�����m��o\{�����.��g�-٭٥��������p@u�Nٍxz�?�PMHE��J� jܮ��|:1󻫱��KH~����}�L,�j~�y�:��ֵջ�2c�|��ۇ�WNY�[zh\�F)}�e���[���k��w����}�ҡ��(��]������//��{|�f�\P)Q9n5^�)�3��7�����q�ͪ�Z���̨VꙪ�L�GW״�d|8���qX�Ƈ�'gq5]A��c�3#Ҿ�lWy�=h�WC[�����JS^Ln��!�Xӫ�Z����ߦ���0�l޻��+��筺�'�S+I�J�ئ��Cm�r�m�4뤵��]�����>�n��Ѩ�h׉ǳ/�\��Z�i�s�������1��`q{k��<�����;;�<8�`}��]e}u�9�G���CU-���$�yW45����ꦖ�E��z/�;
n7Ow]�Z���"�m�\��Ɯ����\�PU���˾yg�}���ƜX���{CO�=��~�:���� Ë;(-7�^V�vi(�����ձ���v���yD	������w��D�+N{ׄ.�����MD^�ƶ;^E���D��|����x�z�3T_;�g)!��g���IW�^��[ԕ]{;��{O��z;�Ȍ�վ��n�M7!�.7ܸ2'�暭k<?_k2)/���ﴟ_\��|��~?
.��˰�-���i-f�����t�gf�_�'�P[r�dV�.-�C�g�'+�,�R,5�o5�|l��Z��n^O��*�6��IS
����ȼ:Y���Zy��ݝ����(��G�bO��{i�;�j���I��Ac�p5��������Fi����(U-M���7�0����3�����8���������q�?�����8����&��?K�-)V�7t��=��ỳ���:ᓂ.7�r�&�Es�@��Fy��)�4tX��U��	����S�+�I$��s�..//�,oH �{{{����$ն�||]�do���6W�^�Θh'��Ǐz��e�$rv�ر���܇�F�d|R���+�!!.�>͓�
#|wXo���7w��;��k⛅�=��*?���1�W/؎��^�s�i�ED)|]�-֤�/e>y�[��d��iz[��ҵK4���-���B]�ٕ56�3c����n�]x�豽5�<�r�`v	��e�<Z�#�悙A��[f>}�X���	������'�Ӹu�>BW2��捆�;W�\Yy<�n��5�^ߌǉ��.�Z�5	�nQ<߅��ʉw�3᥋�b�%�9��}S��Ǽ�%RV<�d��
C��R��WͲ�t�pGE��FAB��&���e���>ꒌD#Rgm~�BA�����뎋#���~��c�f�։��UM��:�moq�?��v�����R6����j����q��u��I�l���\�<�,�C���y���O���[�+���
�U�\���~{�gm�9�C
1���@�D3p�p)��`r8�8��7L��o��̽�D=ćm��)&V��j �2���� �>�hfcf�U��;�-�zQ(��ji�`��"C0�F��a�,�p�P8 �D��A�iE�I��8�%b8��� ���Eō6A84�*�X���'�{%v@X��3jI�Cm�ml�����l��?khc�=�.�JL�m�*���\�y�S��	�+1�a*�5s-�1L5�*a�EW.�DT),��t���QC{����X,��e�`d���� �Ŏ [�7�o@��F/�*�X"�@T��':�����e�24Mb�_p$O4��g�PnAjiw�7l�.���G/L�����K�2�)�$m����a���8-c8\��@��\6j$=�"a�X"���|�� 6��dV�V��fNP+['������K�Ec�D�|�Q>Q;�Z�| U���������<�u*
L
}\�6���Aj�CtPb��_�Qb��57�q4,K`b�(�:983�d���H��|q�8���`��F=�;ۛ9�Ai]u4s�2D�eg9� ��g��~�f)�,��g)0 ��!@{M!���:g�KZQڰa��e�I�C��7����m�ߐá�Q��
�,�L�4Hd��i���B�H�`����f
؍��ѬF��:��v�t�Ўb�IJG4�\���24臥�'h ��O \�`������az� �<E�b��.ooi<ۘ�/��X������0
N�Ax������WL!CC�x
�����N0�4�ed���33�����a0ؑ�` ��F�x�������X" ��f+$���x1�@ �.E�h__��?s�F+	2h|�~� vx_o�(�A����8�
�cY�y�	>lRS�*�P�n\8Qm.=ڒ�0�������w������QdT�56YLݸ5��Y�#B�B���3��J�_&�nw8���$���7t���G``Bw~�*-�@�21t������&)t(TJ�2!�1k�Hu${�ӡ�n��{3n���'t�����
��.��c6����B��v�>C�k�?,ٌ��kn����f!y
�i[Oc�",J�,(��ƼS��K�Lf�Ͱ���X����V<% �Ɗg����@G��#^8�9���C"���S=AD �C�e\d��������|��/%S��]X�8p�렽I<�����H�xt�N!�K&�t�X_2�'��Ð�uT�k�Q�cq~�du
�X���`�t�4,�ܔ
�H�B��Ɠ
�m(L �V��j,
h�l�X<�����B!K��Buh���7�'��H�ah��#����M b�D��0(� ������H#V�P���h䧣�b� t(��iM��G.n:����U`� �W`"!t�t��P���鯑��qAś ���������P��B�~��.E�g:�Q�|G����:���.,�WR0�LHG��`FG��?����+��0�ؠ
(��Q�f�O3�? x��_-UM����Zj��7ҟ��5�J�8 Ӏ�D ��J���أ��Hj�?�6�sv���
3��������Xa�6`	f��T�D�1Z��
���+�+�a��Ukѵ��*��dNL��If*K_zI��0��^��3ޱ�2��v���Pj�r.�Ǒ�#|E��m��~�L�� ����� �N@~b�?���k�/��s�5�%���ϡ2���_ �TS�h�dp�Wl`Ae4
�B���]f"0v����5h��[���
����(�l��9���Ěsb��k�� ��s��`1��F8 hE��-�8�����~�Tu��JZ�	�&�	����p ��ҕ���@���0��X5��aB�h����T����ü��Y_0��F��g���c��1pv���0i�>-
ľ�/���n`��6�ңPt�g$bX�X���mEje�`��`�B��]L˟�������/�{��L?�oXu�\<8���ׇ��φn��
��{j�4#X���'-h :hu�����|�s��QF]� �1�u�|o�`�/x_zK��@�(�6����^��
P�����YZ-Vփ�?23�^hP -�	$��'se@��z��~8�H;~��'g@ Y6 f��TQ`�)��"��a6h(�Q�8.�#� ���(��8I��M�"

�X�3q���(�t�"���$M&�����a�@1���`���~��:.@�: k�P0W��
:�6��T�1�5H�P����aQT�"cH�JgcP0�(�E0�4qXHJ��F}0�X��EP],�)�*�jg^e�%��*T��l��,���A�1���.Ȑ_���:����ۯd��Sb���`�ޟ@ĭz����N��4 �H�0����7C���C��&ks� Ot��4���b�j�h���a���3ZI��I�M��=��z�F���P�E�o�QL ��<c���հcA���Ƣ7�/�#� ��Wm����b`�L���fK��L�p��+M3�m���ig�?���V�
D�C s�4ڥ�Q������i:������Y��	��v(�vT)� ~���Q�f��$�RD�G$�U|�qx̠�4E��J�2�@5��,T
L �ѠL���`��̕��^ya �CC�߫\�`Ap�S6���2ku�Vg��&h��5M�?Bm�գ���T���&���H5���q�<g��LSg�棂[��' �@�&��f3օB���"� S���;�&P�����%P�cp��uyr��~���?JSS������g @�k��r���W�x��l�A�?e���+M��p���/l��B*D��?`�c�p�2�ϦPe���h.Nhoڜ�������������fNT<h{��;V����d#j�	MZ�;�+F�@�孃Bo�[u�p����3�F���A�J����W	�w?�J��u���)(0C���T	$x�oH>D\0����d���w�����X@%�x� ��YQ��F|
b�@Ȥ74(�����C����>U�Q?���
�e�r����H��W~�������̉�w�@�!��p��kZ��ov��F�0���uAÇ��c�n�3�8�n�E�)�s@s��0~�cbgkne���Ǆ��a&r��k�6�d>���A�.TU����~�Ŵ
�� A!�����0X83"��@���T�B��G��*NE�v��h �Æ	��A�_����63�r������ ����_����L�̭���f�N~�_E"iFP@C���w�Xz�ǑJ�b����D��)=JB�y�H�����Oal��/B��c��.` <�x4=v��M�b h����	� ��r���K�K�@���$i�2#������fB�+3FQ"6G�Θ��3����V������Ik �n����J��8�e�Å�����-�/��'3��1�6Q���˧��z����������ƽ�_��i�o��(���
������_%m���eT�����Z<���m��"9XC�$�?���-L!}�YE9;��`K7�5i�WX�a��O�(��ԡ7~�<�@�+S#��ڶ���z�پ��g�����'̰|�Z���<^�>q��S׻���̋�ntE��^���~��8��M�<]�N�S�X�x|�{��[۹l'�w~.��F~���6U-���}{-�#
�)������&�8�"�֘��W<N$K*���[���mQS:�Z�)j퉝d���	��$���['R�����������'����~~���r���k^<�Z�7@]�K:�
�~Q��'���%�p��WQXB���XWi�Jv˅����$�%N�d�6Rf	kxL��po�����n!��r>�4��d�>K>rd�#(v*��b�^���5��>ωC����s�Q�sln�i?�mj��ι�G�C��vD^��x�H�r��V������
�7�۞%���ze岃�>�O�+(�������2�Q9Њ6���I
ѢOv)K{7�+%9K��z3�k�~�h��
���f�����a�n~ς��\(��l
���'Oy�K��;/;�tҗ�i;/�,0X�c��@��Q�`яЏ:W��-ߺGkK���)�~<?y"��-D@~V�A]�����W�ޫ\��}3���"3���R ��=��5�GY�'��8�s�O���!.�;�~��%uxGX�y<6�Y��着]�\�wm����w���B�� ���~O^��(�&ѣ�� �.�+����*3���4�&9�F�����}h��)�ߝ?���&d���ju��]K�����u÷i��-�9�H�t�^�e�NiV�4���=�4�lQ���������)U�.�?��4�y�b�����I�^�HӴ��s ��@�w��M[�>�DJYsv�F#Ib��it�J���R{�:�%?(Qɞ�~�X�=�c����&\����]�H�i f��#���9K��Tx.�]�7�W���Bu+�ݙ�$���ЁW7�}_�Ћ��h��2AbR�\�㪳�Bn<	��˴	z3�go{�}���i�F��??O�ڪqK���V�����
Oq�*���Ԧ|��H���_ݺ������x��Q�^�=�M���3��J��II����(�^P��tvib�ꬫ&�����L����]����5Wt: �"��{�+�'}ߺ������3ݧzw�4���y�,3>t�4�A�`
KvvT���pkjτ`���ڸ���y��~F*��n붆v�]#������xa۽�B��L��'���1��^�dq��*�ԭ��u!{�QN\��7GN9��)��-��Iy|��C	V?Yy�n5n�zݡ7:F�\��Z �E�"�vs?\�J(o�h۲P�㊣o.����+��=��y�Բ�ُU�P����3jb*�_$5
$MJ�r��<+�Z|D+����(����-�%�/�`'v'S�|�����Y%��'&�nj��x� �:���!��̹+��BG�x}P�T+�Y�~	qㆵ��z[W��XPu���D�ۏ�u�J|}J2�=��cSzI��}�w&d�$Yv����(6�U<�����C�3���9]U��T��֊���8�:�QI��6L4�����i}�y��i����ra�$(������+�͒��#|��.����ώЀ�C5��r,Ssۭ�	1Nd|�����s�_\؜��ظ�P�墕�LBw�&mr̲����&C��|f��F������(>7V��ͫ�n�����t�A����
��z���(�k��߅_57�Y$h�U��N,%���h�VA���i�_t��&F;�ey���YlI*���}sg`~��C!��'�?��\���p���>a���7��S�B��oJ�+ܦ�X�x�[�ֶ��wy��M0��u�:�;� ��-rQz���I��mڡg�`�I��)mXRz�[��r�v�'/w`��u�B�^I��ȸ�o�?������3CJ�G��P��GLu���܉��9�P���r�u��ʓ� ���wZ���wd�e����s�z �e���I)��Qb��͞���/H啇�G���~=,v�d��ڏ�P3�3�}߬<n�Ym�%8��)�Z�v��j�몧�r��¤�j���y�齑�Ѓ����t�tӝ�
@����큽�ͳ��n�Ū]���O˲�^��u���۟�T���i��pg��Ȱoyȅϛ6P�5�-j�+��z��&���/��!u�Q���Ӿ
�2�dPP�W*das��ޭ�8bU�U��Hb{<d*s� ��N
̟.�>I�����&��֙�}`����y�:3ᇲF����3̵�� �|�׌R�ǂoŻ������r�"���Lxq�Y�G�0 Fl��U�w�{�[��pg�Ċ�a�����i�ϲ>�-�/�:��d�T�x��
��0����86-�u����v|�{�T���E�1�@48cn Pf2�����Y@�Kvn�uv���=!VQ��gu�#%��/�����]�ec�i�k����1)q(����*��rQ�.�M}|כ��H:�T�=DE
s���
�B�hU�Gj�!�lV��u�
$��+�ࣃ�g�.A4p41ST��@*��
�V�a.�����'��_LCLI��:�4t�Ɗ�ĭ?��B�P
s?Ѱ���3���{s�mw�&���4nh+�@��t
��|A/��^K_�3�vi�3��_��%�;��ɴ��85�c���nz�f3-��u�~�8<���q���3,�����{��ɧ�D��0&0�����#,;.Pࡩ?��#R�
��<��Ϟݪ%=�i��������:"���F�Z{M���ͻ�U�����z�hWs���m�Cq�Ҫ�>���:�~�K*��q�c��V���bWI,({��
s�!S�`���Z����3
�M��hmބ�2.Zz�����$?�aJ�׷�p�ô��:��A���k��i�P��{����ZǟP�/���.�W?�/�gɇ/�"��F*�\�"%���V�/��v&=�W5%<v�᫔��\�0HA�
�Jh�n���v�� A��gz~�ó��n
�\���
1��MT"��#k%%���cȾI�oaTd�h���zo����w
���WZK�7�>��%�X�����ػ"�����}©XpF�-��Tr�r�b��8�ʒ���}E,�F8)W��=(G�,�?W�U�-B0h�80�4��SΚ��v�Lw�嚵�C<S� A���l�����V�Y�9��I��[	,����o���<Xl��F�E�<�x��U��[I�d�.gn-Gj4���H^X`��aH=Å.���Et�-�Do�����㯡g���Nu��.����V��kD32h]��2�4|N%��:b����U���:��/�'ZQy$Nfpg�f:��p
���������()�1�L��{Z~�����l�/1/�,�2#�]�s�p���d
c
E֙N.�
�����j�0V�>Y�~�n�& =$�#��f�	�-� �|-DY!
#M��\�yFS4.Y�����4�2�V���M�.��Z`��z`*�Ɵ�k��
�O��gϹ:����������7�%׹U씟�Z��|ZţR��$��2ͭ�}�UᮡS�C �)��ӫhF��k����e(BmpȔ�'��-���),�뵫a!���a�F��������`��>�xڱּ¨���K�`��(3��jK_�V��Je�b���&��f�t����f�3��M
�9���]��eL����a�]�nd�7T������,��j~����5���;��*�t=���Bf*��a�=^�^�$/�BpUg�o> A�x6����>��J(3X����xE/4VױΑ#s|����M��ca
=�,��{W�s�ȴI�/E�d�.v�@H�����&�Z��n���3��bW�x¥ײ8�~�kd��у�☼<���֯-$��y��s����EM��zuu���F������e5Ѩ��2&k���=�� '�{��CS,d�Ax����3���_*{t�tE��L�n������N3m�3�7-V��ּ�f3rr����ݚL�,^�SQ?�2���3^(�c��e�G�"�8�s2F٥��4�ʣ�db�u[�˚�:Y��4��WZZ�Y�;(�Q�x_͸� 畞xV)�SI�-�{�A�<k[��_`}��s&q6������F(��Z���b~��=PjM��cYGe�	�
��q{W� 
�;.AZ����$��bI�B�5 k�辳��!��3L;�I��%��8K3=Y_�n�^������V����K��E�+'M�,0B~�?��m4����FV�2$^�ћ���`.3��q�!���n�ˬ&�@TZ0<��.6�Q^��>:0����q�x�"�1ȣJ/��,S�g/����3l}��	���Ī�Ľ���#��E)��� 2-�U��������cw [�>��f~�v�B�^��L\ ��j[I�p��{7
g#Rm\)�_d���[�ka^ë9��kyW�⌀�m�'����>�I+q2^~B)ٜ�~�n��I]L�Q������qҳ��jM���,R2���?���!���C���?�5p�(����uc�	�+�"��.(�K�'�����j-<��v�k�PE)���NQ�i����Μ��W �� �R2Ԟ�
aϡ>���Xt�,5C2� γ:�/v~��/*:�B!t�4
�������;�=(�m���ӻ�m�}�U�$'{ ��򸈳��7���ܷ3�w�@�h�b߮}ZgV��r�:72@K��E?7�LJ����p�P�h8v+:�j�����}�D�g~P|Ԣ���+�������	T�BLm�"�'��@�=�⮞�֬o*��b����)�F.�SEO0�Q̀��eY˜�-�k����(zn�!Uвe +�D���x���c����V
��.�R��k���FQ�v�K�O���U=�\�]���7�4�����
fCM���:U��ϽekJϺ�hla����
KDLC�{���E_��v�at!N����T���
��~^�4x�0᳓oQ�� u �aǥ̙xP�ȇc@cY���,c�}"������
���۽x[�c�1��V��;�AQ����y�
�m�꟢�o��_����8_�P��j���hdv1�R��h�M��}8��G/��F�Qvi��}�՚J5��������1�F<7)`iw�2ď�x:���ㅦ� �W�۪B�OTԖ%���}�����s�-�~�Tͭ���,=�
ƣB���ΎD��s�ǩsp���P�9�����K��y�ͤ�������u��2���(bs��Ǌ��-���} �Qe	s���y���`N���. �A��A���4GO�
}�O��܅�怸@LwZ��C�q���*���S��{��Ke���%��1�u�^�ddKn� �z�`.�%r�AwD�pk�s�|���Ng��7�}��_�<B��9@K���,!��9(F���fF���׫���.�$���o�r����s<"�P*֏�F��t��ȡ�iJ��8��!R��
M� eAO�����-|�'V�/��W��t��Ύo�mig��̘,���M�3��
������Uoص��CGXy��/�/��T"0Ehjf�a��T��i�ǯ���;����۾����.<}a0�5Q�u��"����(2��	u<�.�f��5פ$�=ҾI�V����^T�~A.�$ �b(gT4�ߕ۟�՗�$P*�J�ӲBץ@M�*˓wϼ9I(r�tԓ1Qu��u��:�K��z��1N	2��QK���F� ��%�A&��Y�Sh7�򉐩��cƓ/k�\2V=�����9�W��>D��ߩ͉�<����Q�h��r��
��г��K�z�Ohq,��5�'�SG>kꟾ� $�ҧ	ކ�E<-VH�7_�Z&��U�:.���Jɒ��hVy�ZPl�,3
��u
��v���^
���9a�)��X�0���kP�r����cL�C��Ѯ/R؞w��
���cX^э_�|ڟQp&�Ji����ߠe��-�z3��>l�_M�#P����~4m�$3.7�kr
8��n�~e�E��L	*�#����T8G�1��<��<�}$:AK�C${�C�Z{�Y���&�g`^?A���0��~�dP	�������.�P�FQ��g�8e���C�UŇ�Y�KC�����f��Wq,�T ��"V���̇��<��Z�	�_"\��|I��ǥ��^5\zID�x[�P	q}���>�I���#����.�I��%���h��2�
;u��nU�5��P0��ǘ�!s2�4;q��<�>���b:[6�(k4x��Ilg3�rk�٩ಗ@	..��gdF�x��)2|�k�n۔�����;�xF������V!���>�Ȧ!�+Y�(�C��P�p=@QH���w��A�RtE�����Qr���:$!��Rɍ�
������T9��~���?Ri�"�H�9y�c/1���,��!��0PId)�Hp������o8��1g �LW������
�I��ݥ�WD�wc�=�c���a;LA~�m$+]p����X��ܐ�-�%r ���s���j�yʻ>t���=�Dk�}$[z2�	aY�mɦ\�ȫ����d'�3ڐ�o-G�w�_�⊬g������u�{�~F���
A�������mh�v�:LPWM���=�����-�j+����<�|����S��e�V�~���#h=���y��K���R�7�iV�7��:�_���(gv'"_�[E��!C;���W�����1�r��L�����,���MA����k�"��BX)��ǜ⸱$�	�6K/�I�l$O�@��Q/���[L��6X��%Z�Ji���cᅫL��zL
�2nD��0��m;z'̼���Ճ"H���p
��(���Il �Y��Q"Al���X]��n�0�0���^�㧽QwȓSxR<�L�g�7q��*���.�l�������0����*��&��4�:�%��	
��b�v����	�	ui�������BPW/u�%,\��� 
��%8��̓U^x�����O܍�K��0��E��}��K���ªw8IJJA���%�_����^���Yr����Ұz`��\
����@I7�R����12�Q
D��"Azj)	Sw���2P{�6���1/��#���+�ߜ���34W?�Ʈ���];��[?���p>A��VI����z�����&&�I����lw����(�[D�W �A��a
����o����j���A� 1vc]�L��iҁH�!�o6|��y0f�}b�0��Πb*�i���뽳���m"8���޵�f�n�V��-kZ~Xd��	����݄�+�xR�)Uk?�g]">'���6�qZ�Y1V��bE{�%�ҝ��j�(�6cJ�XBjp������C���ￅവ<��w����5���Vly��*챵����� ��IRWA�E�l��cf<�/v��	����(H�3s���w0E���d�m1�1�u�Pҳ��<6t�� M�U�@N�o?���o�_=���v!o��*.<��KZAb�������Y#��>

C<$��Q9� �=L'��5<,�V��� uz�a�Jw$���\�ΧY���0
����������������_���������p�?Y�{ͥ?����V��}�@m7ZkO7kG+W�_���98�RUޕV�[�VTvr�{�
77u��?���;���au���h�~���p]a�o ���'������Paŋ�6�o��n��M��-�~�4���߯�~Z������-�{������u���7�9��/��0��d�1��/�9��>�/&��c�~ӏ�q�ߟe���\��&���/��� �����!��6�#�����O܆���������z�e-ʟ���F��ݣ7�٘?�ͯ�n���qT�_޼�#Ԕ_��~��(���V��oe���V�[��_j4���
z�7�t�G��A�~��G#�Q�~��'����?���H��j�G���o�#?��t�c���0��R�n�O���<,���/	(�x��_���'���T*�?��*��翌O������K��=oB����Fl�3[���/!��]�K�'�s?]�π!��`�0>����yп>Z�Y����Eh�bg�i�3����⛽��㿠߇��/�=�
����|>�G�WӦGX���ß���'V��
��j@�	�?<���?���JL�	u7�`�S��j����?L�.�ܖ�"n;[n0�����y�����W|������������"p[@H�OP���O�GH��~��o\�X}{}�qZJ����A��H�$ �5��䴴������N�*rr�N.`��� ��,][=�

�=�qq�1D��Q�(+tyq!/"���}^؏7B���&$�_dU�@P1��okb�R�-�twt-�pI�3:pQ+��\/� '������f ��(* �����ٔM���A��UQ	��q�� Ҋp�Y��t�� �~K�e�'��9`m�u��0J�#��M �XG��^ߍR � mT;D �� }e�� d���	�юx�
@���00xB� �����_��p��`�J��cQ2B�tF���fR!a'4�7O��j�J#���Y8  r�`�\za�
�t1c},�6���͌��4?D�~�3'l�6`-��Ι9jv+Kc�L*�9ݧ8�(�8T���'t�ʈ�ь������	ʼ:Qz�@e�}	x�p�b}�X�/�"�Q�71�B[�#f�\]�y�b�{+7��x�܌�.��%b���/���)^R����v�C��vٷ�h�,��ҿ�,�"s�5BC���[D� � ��,�9������Ƥr!-%#?�'4!4�P�6f�g���n��v�Z��(s0���p��D�u1�G��1�=�Wy�R����:E����z?Y�W��$rв�<^�Zi_��B�B�o��e!���Dw�E����U�U�Ud�T>��t����zx��dK�W�k�𻧋�����%���'��+��V�7�D���^�C�������XaD!��,d�(��d��j��F�ɺ�x�x�R��p��@�j6_��>��;I��(ظ���_�c ��z�E&�~e��ۺ�Eh�K��YZ[���Eb��Ŷ�`=������Ȇ�j�r/�sߚ.7v�bX�Uzr��c���	t�z;8����!���!Z��蹈��;��+um�P�S�O2�4 o����Y
R���wY�X)^���Z�싓S�
8�ũ����j��K��'��,�&ԍ��S�Uĉ��-3.;t9t���|����N��z�+�Wbjbj݃�y��i�|���5f�<�qTV�Z�T��{e�S������a��q�biV)�xCiC^A��3���q��7_�{��j�ެN"O�U;T���Z���t���<kz�W�{)��>�]Bu�������]ѹ���)����
�c��	<��нڨ�l�GG"&�@l���l��O�$4
x1v���X�e.zҨ��6�!�M���ցOB��7�i�g�b:�gն��k6��_[?���t���NB鵯|�ɐ�Z��g�{,l(���6-��}"�%����}�O�2ws������V燩�sR�5�~ R!��5��L��v��xmT5�Øfɶ~J��-ou� �־��*8�- ��c����mcMn��*�,
I�Ȩ2�i���I��U�pp_K�L⻢��:�a�6ks��F���)k)؎XS��a��}�}t�0͝2�2�R-W��E��Ѻ�whPLJ�ޡޙ��·�*�Ǒ
��c�/c�F��K���i P}�f��\�*UY�q�|�`\���ݍ����z����	=��q�-%�n�櫬]N,A,`lf������mJ�%��Q���E�Q�GT�T�d���3t�ύ,��5$G�7�/��ip2��
䆭�oe�\�]���s���mM���<O�Oy�����	�"+��j�n����krx�|��cƃj��<��/m ���ӷG��Ο�={v���zpay�s�o�Z*� �L @` pz
 ����v*��3\1�~�R��a����5�8 In%������tu��p�g�O�}�g�+{٬��nM�5i�i6�����+M�L
r��w/[�H}9�%�	y�-�3<y����%��[���1���i�����JYr��UAĦk�]��eˆ4�ݦ��{_J���܍���.O}��P�������(��j�������O��_�Ji��u�����$|�H�)�X�����ؓ�w�_��ګ$��gf�����nҿ}0�s���{�z����x����p����bww�j{Z��:�=a�w�-ue�#�m��łD|���TC��D��=g�l�;�[�Y����$-���*�'j��꛱�*�)�QZ��]������ܤQ�M)�����i���������O�_����������
4s��-�69�~ֆ_���Z�,�(spIϏ�)X:�N��-(r�͍U��@޾8�[���	
D��z4���ad_��_��`x���0y�S���r���r_�؞/�K]lM������r��ju�!-+h#
������<��8%B����g@r^{�πN9��:���t<WZ�VZe��U�~������S�3-� ��rӖ�nӳ�|_N��!M|x��f�Ud�P�xj������tc��"=�,�66�yU�?[T2���{�Yp}i_6�`��
ol4]�����ȒWE,O}筵�x����Qr>�)rA�	=x���?��0�"[ua�PE�]���L2��L�cr���$�"��3ݓi��s$��\ �x�����z�uwEP�X�o�/V]�U������=�s�׌�d�Uի�^�z���UհW}�x�)���qѳ�=S��t��GN�q�5�O�f�;�{ưw����|����{����_�c�w��ԃ�����+W,�|˰��-�L�
�����XY;���/���}+��F��eS��ȟ/�͎c��<UV��u׮����w*�M	O��0�<&�/��Y}�G��������8}��K߹d�u�u���so�����w�N�p��
w��i��;�_.|��ö|���O�\��kZ2w�2�6n��k־���ӊ7���i�����
+>��nc��M�F��Y7圇�<0�u�N\uƐy�<��;k��xrڪ�����o]}���_5漋���}lC�O��{S�iE���\)���^nՇ'�~��X��W_4��x��}���l
úw��?xdk
�{�	��]���3�3�&46�6l�����qj[�������'/X�p�����������n��x=?�.v���,��Y�'͚z���v\>42|����Cf����[�������|t�W�o��I�{S�k�cw�z�q��2������������������O�|F��Ëֶ�Ϟ��k������0:���V����k�����W����W�3�єV�y��Uk�<&<k���X9n�ݣF>b���o����4\{�׻nx&��[��R7z��>��w�67
w\�x�gK�M�pꎝi�7�s�7ߍ��"������o饟.Y}ݥ{�����;';��=�f
�L�[�����S�塣���|���Z.�|��w����[/Y���8�dW�=²�S������;���Jy����3�oo�d�]��N9����/>���s���q)w�q��������{��p�iؾy���v|�1��χ��m#O�:��!�������{�ܔ5��o*4�4�<�Է�~�-��=p�{Ĭ��?���뉅�}�k����o�x���W~q���+&qs�|;%�}D�ɳ�~���o�X~����9��7X��?w�[?p��w�E�ˬ�~pB���0)�n��[vF^���}%��7>[~����߸��u�����I㫇��xԨ�=oʹ�n�u+��;l�Nǳ[���g�ۣ����O�OW�uŕ?u�����>�h�1�n���ѷ���)���rfj���~���+g�sLqIiS���&Y�~�|�<k&\����[6�����3>����O�>q�7�ZӅ������T��C'�^l���'������c�s�z��;sfWy����ؽ��e3=��wŅ��!ge}��t�ͧ
^qO��G��w��榷�L�a��6Ӗ��&���ꯩy�����c����%g�����}�Nݱ���S7nZs��=l��s���s�����l��ǎ��ZP0��������O�n}oD�G?���}rL���̹�8{�λ�ȸ��Izo}��î�n���������+>~`�_���c���Y�K��Nx�Ү떽y��/��;b�k���r��ܺ|�9��j|���|�����/��y�3gg�<ad꬟&>�yEe��w����82�馥���o��r����v}q�+'U,Iͺ�,ӷW�u�;�n���V�8�����K6lj�����?Ҵ���W�P�z�S�c~�懦]�/��W5S^*>��a͟*�M��YV0\��;o�Dw�U?~p�}O�r����^y��ֳ�>�^��ݟ�S��Nn҈�qK>�j�姉N=}�iwm���>|0x��µ�u����<z�4/���㌭���_����
'���~�o�抿N�v�}{}��[�qWo�j�Uŧ|�Ը�5z�M����v,m}𿋷��7n;��O/�������p�3�o?�zj����=����qǲ�G���O�����/Ҏ{��G?z�̟�:���?|�������W����?g�|rY���O~>�u'��ӹ�SM��9$?0�����6�O�z��Ď��Zss�Q�Wn�Ֆ���Xm9��`��@|����?�]R!� o _���� ��,
�DEFO8�1j�qrt�� �q;ؠ�I����qK|��-�x���9cZUu��ii&�|��Ŗ�?c���D��/0���<
wyy�`9N�16k`��bEF1���9����?�� `986��9P?W����n��3sI�F��bX�����4u�pG�&;K3K�T��Z0^�Y:���	 �V.�@22)��B�d�Jq�=(�M	w6
p����A�,������^0bHΩn��n���D3�Ʀ��RݝA!�a63^��ycڤ�̤ff��4 Џ+����v���*gRR��
%����15��ੰjx ]V�4�bI��P�,���/B�6E_aE)7�R,��Sקh.!�>.I��,	��B ̄�.�j|QV��s>�"�ӻ8�[��r�}V�%�b�Z�A�v�gYj��1�ff�Z�b������h�}�6^S��F&���2��F1JS_�4^�LN�B���Pr,%�(��h�U��=c�)�p:�F�P.�KuQ�Хw�׆[/�,�4�fTҤ���<v8|�7�MdFxZ�1���'�/���
��SDXN�7� &��`\"6j���e�r���R����R����g���or]��n7Ԉ�Q�@�
��C��O���ճfW75��n�Ik1�Z� ��J�#S�&�j0���$g�
�9��k)9R���eD�	Tt�"U�89\}$��v"Pq�Oy/k��{���o�������r��
f�W
�
�I�=�`��$����x�`/\��/���P4T�f���Q@O@

��b\�c����D
�Đ
5�yռʘ$2����_�o�� �#q��H��]ʕ�� R�"@-�uq���q�i�t���
.�i�H"��?>Q��A�a\7��q��L�7��:(S�F@~j�\D�XFr�,����"���z��"���f��}|�U��.8S�P� �Ҋ�S4�$_8�^�� �@`qz�i�i�J�q�F���P���K9I��iF������t��7�����:q{+
!C{���A0Ȫ�>d�JLҴc����)��sH8���x��u`P���*z�"�Z)���E+hb��H}K��JZ�;�"QR_��)�i-�z��[5Y|�X���:���Q]햟�9$�[�U��ܑRaҾ2�'M�g��d��D��;Y�{G�6�	�/����R4=�Z�����]M�1�.'~�����v�!�N�6K	��4+���V�9Gl�{�<*�q0�\N�����#��y����������Ž��1[�y��Գ��R�C'@��L��؉���'�Y��a�C�y���WA���6rM~%�W�XZVV*Y
��t�Z!摻�=N�#W<Ԍ��%�7�������>�NI)
�� �� �w���`���y��^Ŵ��
�����	����i�]B�o���u��E���I��]�Ѣ�&��E����a1hs���,����X�`A��i||dI�B �i1Ȧ�(��Z0�+�-�t���X�5AK �C]〟*	��<���z�@Hpzy�&�]���r�Ԗ�'pM����A�d(����5�ꈬ�2�o������tf ,Pz����[�%fh�ĕ�R���,��i;����#����c�T��2��~��~z�O䚜p���KYw��u���!�NS�y�2%�4fTĆ��~mV�� ��r�_v	Y�!�m/�?p���/�"Ax�g��"���"C��C��w����pI��A�;�E�>DK�-�L�˸��ڥ(ݵ�f��(���_���^!��.��Av$1�
ʇ�f���+���,:oq�*�!p����q�N�uc�R@�Y����'�Y�Y�(z+*��o���Cr�=|@��8ھ����v��w�5����h��5�$�I��%�[��*hb+�҂�M�������|�`=4ɵP���o�
�2!�CŴ�Nr��g+�T{���}צ��1���R� ���?�۫����I)�`h��j����bi�J�Y$�w�����E�[E`v!ld7�
�$�fc賭��`d�YSKm��;��x�.��@j���f��^��WR�^�0�$��
k,/�~߰gA��ۥsՊy�uzyڏC 췠���EQ�~��G�}a[�J�i���L��Bh	�1����S
��vm�>� �3*3��H@7
�Y�`/0�Ҥ��LN�U{�:��G3�
�����F�N�[L�['��n(�iH8w6��$�?�PZ�����J��aP�I4��On����9tR`GP�#�F.	C}�(�vuP��
�U��+�f����,;�*W�ɍ���"�]�y��2�r��0 ��hxK_$�H����V���
��ǜ+=�)o�4�3���g��>t�
Qg:=�t�H��:aR������0�?Z�mQE5��*�퓹ߩ�V�N`���SG���tq��}#+����[3εB�֌ߜ���)�
E��W�h��M�B�����Ÿ���l�F�Epq�G�����^-J6�~�M��`��QL��4�C�j�@Jh_�f4�+V(����sŊbIP�?1V�fV.
��=[
����5#
����dk����*ǜ�]��u�����R	�;z*�
8�a��R��f%Uɜ�*D��#�ݤ4��6h/7��ـ����ᒭBY 0��"s�>��1P�WDL��8����F1j�	䐻�.�>>2C�ܳҐ��}�#��v�bmi��N�!�!�!R�#C�h+���� �l�b ־�/a�C�9ny$��Qm`2{��B&����EN�
�=
�aGbϓe9ݸy�s�Q�sJ3,^�:"+���fz��>��M�t���E뜞�2�W���CV��*�[�棁�I�<�"8�nh��XS[[w�U��G�&t�D�L���ۣa\�\����~�RF1V�d
��i�����|�aS=�)!V��:T)tu�$b2�6f�7���8H���X>�1�΁�x����g���+�aYk)Q�P�By��:��+e�J%�
S(-|0�b^�l�4�'O����I�4x�r��1�f�l¨g�4'��u�
2{�<�؄d�J�Kh�$w����7"�hU(�"�_.#���v<K��?��CR�(jh���=%���=�����+���Nf�������K�0����#N�)�4nĦ��fT1׈�$��Uv������}�3�Gb�	H6��C`��N��z�����Ѥ8���g��j�i�O �Bg��vr����o�.'��'Vc�-Ɛ��AO������IrPK`0�%�Wk�����)=����X�㗆"�M���g�b�����(�:֏��j$�����bQ/!~�˓u�2-�~08�W����f�+s��G����V{^���e[���{������cq�K�A����0��{I���� ̄l�������"{ �٣�3����^A'�˨:=�a�X_��������� p��+��Y����� �����d�Zr�v���`��?��?��A��a�>�X^�9��Y&?[�)��m c$�5���,h��L��𵙊qm�NtFc��3� ��0��|-f�ҩt1�����+_�L��8�ז	�E�bM�b4�Y�\�$�D�X`�_TL�%�og�@"�MO�ݛ�0c���ݸ�x_B���}K��"}��
����~�j��M����CI�>�2�Ώ*������Z��d��S��04�ݿ)��d9!*b�R���t7 +���!�E ���r�>(���v�Z
x�^$�aCT<|b����Ķ�qe���&M����\%��RH*p�4���+Iz(���Ԉ����������>��ß��ݖ�gW���O`p��O���5@���?�KFW
��Y*�	ͥ� )0WC���`Xn_���"Q���N�,�Nbf�)A�)!�tJ�
Drß꜀��P���|��-�St?�T4��űA��TLgI��.HX���3@{�pX��(c�J�ϊǌ����
,V���ԡ�bŽ���ե|0�W����z�x�l8/n*�US9����U�L뚬Ŋ<
��ڭH�4��xeT/��b,(�/��V�"�+�SW��
�MN�4Bw���`C
�:VF��˾i����!.4>�_~��h/�n�Swz�mt
a�@�̈́N!�h�զD�01,tI���)փk�aR�cG�*�b�r)
ɦL�|>PY�:u���������kY?���Љ��u��� ��J�'%d�N)J�Iѻ`/���(����C���b���o��D��� �G���͗ʓ����dP>yNJ�;uC^�A�xnn���~���"�Gq>�m�Dj�+	�؍�+S���zU@�U�F�q� �Q
���tQ%��ӊ�ȣ�RGTd��C��
��_ёM�`X Qr�>%{��PJ$N.D�g���:5j&�@nq�x7 Ax�|�9�����x�Y:�J{�E���w�h
eMq8�������+�_ftf�y���h�gt�LET~(N�R����@��#��L
��� ��ޢe,���(2�ⶺ�n���� Rt�5��������Z�n��lg��	 0�� \
�����6�;ם˹�o!����s\���\b�~�o���s��x�8����T�B������� X�ڝ� ��N����Y;~G�ޮN���xgA���r|� �u�,���a�� ���bE@?�D���
m<������ε��>�*$�r
sy'��"��] Yw����ǹl9����(�rlp�e���\N����	j��ʳ�� ��/��� ����r W���.`QΙ�G��;������{�^D����:���+��%��]`�����v��<G���B�m�/,��g	�g�z
�NW�'�%� �	Cp®ݝ���p$�8�BX�.��a��*�@
\6 �|  �p�r
	(��Kj'n��ԓW�?�&5��/D����X
��i� �Bu����ͺ��BZ(,2k�8Qވ�X�kxpFCNЏ4�`(,!,��j*��C�����+@��
��?E�(@��~w�^��P�������.�������
����)�>��..ו�°6HvT%����va 4���|^(�e;`�L�D��fesȃ�Zݹ����w����8���Fj
{����nu�Y	.�eA��wK`����	a���N�+��I��	����v�!+�)R :1������P�e[!�*���b��yN��+���<��I���m���q���P��^��0;���`JV�.gv�MJ��F�3��祔  �MV70�bm:r
84`8�����������Vh+̇|��+ȳ�x�sÖjBᮠ?${<$��r�!�G@N���v�����x�C�.q@ ��Bz�S7 �΅��L4��V+��Y'����1R֚�E� s�v�>�)����Ƅ��؀.�90օF�u��<����
���� ��fXnH  7���:!,A�� 7(�ԓ\V
��4ǱV+���$���H[%�) 2�ƚ
�K��G����{O�-��X�//�,p��ڲ!T��l�5�>N���as�@t�����򀾈{b.�UH�}>ثXk���A��E�,� V��U=��EvOa ���|b�g�JF��� (e4r�
�о��U��wh��<2�Vb8��F���̰��~<>d� >�
��I�1P(;�����=xi��4d"c�~����DW�
K[$�d��
û�qS���mn�%���|�G@д��{
��tJX˽���u �� %�Y��FP�d�YMY���Cީ�f0o6s@�/������<�4���γ"��ns��c$
���L���A��@�`<�"OV�9�S� �& �w�.����3�c׬a9�q��U��p؊\��]���m�y�26��=I�+����Yd/ͦR���l� H�M��r��:рd�#_�;,��P3�-NS�+*݉R�PU&��ͰeeQ������B��  �E�n3(�Ӣ����a���&�D�0�y��k֑t�nܭ�ޅ4��U[0��{�`2�w�0�PD��I['�Y�9���c4d8-���m#���X��ի%�!@Y���ևx@@C�(t���1!4�pNK�'i%xaU��r�l�U�+�D��2O&���)U:�qF1�b~௱oX�[����U4�Ȣ,��B���2�9������.���WH�������m-fv����b�� 2��fˊX�_S�i�$����I�c��^��"���75yl�rti�J7�)d;?�E��^��oȍ-Q���h����!�8�()��-+��$N[��&XdezO�)e��l��<s�5��e����7E�6�Hn$j^�<�)�=
��!6�L�?zDP�6Uڤe(�k�[�ul;z�����gʫ�ķ��J��
�x.
3����_�0Pb ����}5��q���߇v,,�e�}fƂ2f� �@& �}pAL࠹_�'�ˀcY�<���7�請�zܠ��P�dPL?
��+a�"Y q4���LH�^͙y�2q��0-�h�u����@b�rH�)V�n0ՠ�Y`�pyRH����%�Lq ǽL�#)n���*<x�Q	�xy_[X
���L�I�Ӣ&Vr�
r��3j��~b�X�*s��C�� ��?S��Q=q)2�*�ą~�D�	��t��rU����pLj�F�J��(u�$�!@��Q	/d
��H����U-5Ar�<�*.���*Dxh+�D��n8#C�:�����SQ���Ȃ�vy���B�C�
sZ��ÝM�����
����j��0~$h�&��X���p�9��NΌ.R�w��������+V��U�RQ|�,~�[i+z�@���?���S��CU�qR���� �|�|����S��u�Z��&�k�V�в*O���omؤcМ�DJE 0�N��Jj'��]�|��h*�=H]��s�3
C�����h�t*~*�2~���|����u:k�1�
�&:Px��9�,+���<�h*K��ߒˣ��JOGnQ��p4�	�[A>$,�c�NrYqxJ��<l�j��$ٔ]��|����@���mh�9y2��;@�U�Eh���HVg��Cs���E]2a�9D�	�(2%V��
S�n�(�+y�/OXc�@B}�VU�9����ʢ�͙9���`�b ��o�c�kT�Ej��h#�`_�vZ<ނ�`	�$��d���`PԮ,�&b�
�&��H��2M((���_�$��%�t�C�p�V=��ˀ����t�lx�����[�¸�,y52j�W�;������h�m�?S���\:ъ�#D��L4�ᄎ�*�0F&x\wW�?WJ�=�nJw[0�c%wD�2�N�K�eN�?*v��nS�
�^�(3�4P���1�Ҫ �x�,Zl4��*�#vU�
r� l-a{;Q`�4:0.q{�=�1�O<w&��@�Hő��mZ��*�V:-V��Dq��,{oe�`�0�6�bMf�T���:�_'n�N�O�?
�W`al����֦})k0!�@,� :�>>s��"9u�J��Ч}��/ȳ�&W��\� �iB�9Anb�_���N�2/ތ���K���� ��t��y˗�8т��c��h�f$��Z9�C`R�3�	�x���B"3�ŀ�o	�A 웹���C)�m���Mm4j%�+�9�E���#���M���&�7��U�F[S1����F
����a4˴��Nyz%*a��KʜO�AD��E��G|`ˢI���:�e��O�l@H�y ��3�:��:Mp!�&%���&i*	�g1��Rq]ij�� �j-ɡ�>��&yMM�� ��HP�X#�nV��lT�&�l��M���z7�ѻY��픃c�f)&VC=����`F��m�ޠ�L8p#\IP�,jf��J4�Ӣd�"�M�r��F:Q�!�ĠU;���K7�� -�ݛ#_�F��fg�~Ø���J�F�-�B�N� 3�FR腴G�r�M=��R��ujVF{�4Ge�·�DS���|�) �L}�qB�@� ���fb��޲S�5TYA=��Φi&�N�0�y�X"�.?�����"Cv:�*�_=/eKl���d�*�W#K��
�0�/�eME9�xÓ=�83V���F�YD�"���Ot/�,M�F�ŲԜO��΄Q�	�~ʦM7< �Қ���o��+��!o���UE�(dv���3OM#��E����,�oe�8���q�9��u��Y�����Ap��6��B������Sy���}]<6�<\�1i�b�ʃ�o�чnq�2�͈��e�"ww��,�ޞ�E�-?���'�'�����i�>}:���������s����?
�Ox1�X3�V�vN9��Z|n@u �F�7��SP4I$��>{�
��!WP@S�b5&b36_�L?R#�oP�+�#e�(�\�׳}�WV� !n�~M�P}I����X���[$v5�����Cժ�P������*CF �4�� ��	��xj�d-�Cu���SO#��<67TFm��(6A����6��y�#�jwz�J�ڞ���У�N���H@�e�NWH�*T�^�Գt��OQ4h���O�Q��f�}jB�Ka�c��
�P�Pj�y-���t���c��ՠk]吃�����l�`�hc������j��A�!���Q�	v
u��E�V^/����V��K��^�-$� ��<V�'��cқ
P9����i�(t��R�/����R�aJ2��F�jW���9��d1#����䟢���̔��DD��A���
��rُ�,�F.��8U(q�#��8}
� (#C��֘Շ�
-�S�T���d���T��D��c
Չ�������x�"F��,���d,�(��2)��
z��'��F4j��7$NM��QfUYXT�g_����b�T<(�~(�BH��24�%a0.��'Ȼ��[Fl��ɢ�w��Ϩfb�=��V7K�X�O�A5�әi��`�,@X�u�X�/I��5`�B_31UD����#�����
�}`۵�x��*3��H@wQ�YN�Ri��`&�e��h��=���0���B��a�)�N1ؐ*K�AdI�S�8򗐺F-n)��߰�]���=�>��q7S�����ydM���R�?��3҇f9FYK�����x�z���C��"{튊{����	m��~�)z�1s�����Eq8���H��i�d|8b3�^�73�K<cmYknx�q���X�R�Iz�4���xQ=�]�<��R�cZꛚ�7K��t�b/��v�b������{�"���_:OH�}�~$�)�Ew�^с56Ҵ�Q�g���H�����b�6�zPԂ/��
����WQ���q�P��z*��D�e[�w��ԃ�7��n��<�x��~a���
�^u�YB/�E��B�]�+9ޥ�/]�����TӬH;�oȓ�?cZ)}Ƭ�CU����pZ-M/��C���������g�{*���]q�����l��O�����?�w��|�1�jf
i)��uVzz	 3\Z�G�N�/�x�x_fx׭ad��i���gfӳ8���c�g
A
\u�����,b�t1ﺖic#`��б�R��g\���7f�d��@KS	U!�;/йZ�N3�.���8+k8C�{�0��r0<�Ǣ,�(�y��v͢A�E���Jpb�T�B���������>���`/��X���	�.]B��Pr� NC��Dv�&Wa@U���7��T�v)'ʣ*8G!��B����R��B���t�LHM���4�������N�����]��$"g�D�i�%�1GM�+*8���E�Xp�:G��юQ5�v��&��햒�j)��6������¥�p��-3Y�rx�o�"CyP`���B8�l;S	\04Q6c�"�.������N�S����@2U��9���� ��`���@>(�`j��T�C*�~H�j'�2�9��S0��
����Ѫ$	/D�4��ڝL.�@���$���`T��x_SW�ӏ�R�j�o��2@�_���>����|h �����٠s,�A��7�,��V~�1����J�+GŚ��ښJ1�gׁ1����u46JD���W�T��=�D �$�Ȣ��U!P
>�6ZZ���99�8����>e�l��Wx�=5(�J1^t:���j�@�󅾒Gj���'�����}��Gb��Y��r����<�-7Ǟ����������$�����y�ё�Y��)�HE�D��;��l�������UTD�7�L��*�Y���\4Z�
�/�5��hǁ��[yͬ�L���f4�ը�=�k��x�KL�nFL�]t���x�n��9��c$�D�]pѐ,�1E�>
��R ������y�J��:s�se��;t(M�Ǌ�U�	<�E��xu��5�~�|V�.n���Y��ē]:��i8�_�u-�R��!��,�d�%n�+��|
���Cf��x7��
����ǣ��0L�(�81Vj�	�۔�B+}h���*���3����ou�5��\���^��r��l��mͳ���E��W��C��a/u��̵��yQ�?f��1 ��Z�ӈ�SŃ�έ��Vݜ��VE�Q�(0e^<����p0e�Ӧ2���jF�Q�p��G.<��.�5'�� ��%��}���{a��
�^H�)T�P)�C� �7�������*h�
�QA�W�S`�^�$��T^��%M�� {�&u�W���)��E�i��� �c�5NA�|!�������qd���}��'�]mK���Y�v:9����̙��IS"e1�D5I����-����y�E �B���Kw��̴%\
�B�P( U� ���(Z�nkRd� �}��Zйb���H���u/4�3tÔҗx;����@��@�:<J�׽�s�������&�{��̙o�F�>�80�e�V�l=zdy�Ɍl齾H7����H��E6�8��E���Ef�|�����'��geOaȏ�3��~�U�3����3�[D;��Mq&�L�Xe�Wo�Z����[V�zǿ��hr��)�'Cs*����<L5������%�����.U�̰$�MI$0s��[�D7"����/��T$�>�5��(�Z�!jd�(~�ۭ�y�f��֤eY�#}����a��\X���/"3@�
K�6{��J;���Nf�c����엙������3�^̦JUaͬ�Z��ZJS*�{q^+��cB�畸�����e��Z�R1^�E=�@f6�l7��0ۦ�׬"��l1xCY�y%k�{X:��p��+�;ƴ�q.1s+�o�]\�\W`q�N5~�w��+����<a��P�ׄ�L��d�x��[~1�X��_��.5Pds����	b��):/� {cy��f�A�{�b���n���>�M
.����4_�u��FS�%\V���VPVZ^'NL�&/��O����z�5�.-�\����~uS6L	�M�_�P:�Ls���W�j*�/Ȉ��.��Q��lh�k<b��E����>�W.��w\/d���,;�E��4��^�⩥2���{-�w���WNb��REHC-;M����b���ۄ�Y�1"�Ɲ)1�x�'1$m�_�^���(u.ŷ���6�c����NAe;)�@</�|y>��U� ͍x+%�y"On��:mĴWJ)s(��$"�l1��gW.��HZ�����\S�Z܉����(ݙ/�>����K&a��nz'��|+I��x\��(�K�k���9�P>��O:���JO��쌳QW�7���?V��5�=�EF�x�U��Y/M9����ȲZs�~/��i���q���^dEJ�ь��O�wF����G�/Ow
5���;�Ď����!Q�
��I�(� ��5��%ɚ�{Y��H��&����&����\��Fi Ѝ/���z	i˥�vO��R%'ƴ��[r����wٯ�҂|1E�M�W��:#���|g}ذ9��^n�~z�d�	G~mM��i��^�+yIh�_
��n�����c���N���T�r��^�`e�C��i$�����k;�1t�?#��.��&�@����'�$��i�͒!�9�bgH�l�>���Z�J%�۟g;�)�(T�s�N�(=qU��Σ�\;��\�x��t���7�b���#��nV��=Ҏ��3�=��<z��F:W�C~}O�����������\o����_���ƽ�߻�,����Å]�3\">H*��kWZ,�?�d�=chRz�#�-�ӕ��w�U8FA*7HA��t5�a�j�&,�u���.{1��(*�P7��y�nuJ#CJ�;��+��T{v�K�M��b� �8Ʒ�����r#4%m3l���S�?F#ԣI/�nW韴	���N ����a���'�9'�t4�T!���=�� ��λ[����@���u{^c������hmZ�i����vpDx&�F!�Fքo}?��A������� �Ƭ��[��E{C���\����l��l��t7r���#��h
�$�~�d��$M���!�����&j���C�����f%�C�{�s�ZF�D���B��@��[�`c�l-��O�݃��	3䲊���j.�r��ܑy�+��- Ck>)�y��T�4�ʲ����Ⱦ$��p��NI���G�nR��Q���G��t6�[��=�"�R��ۉ��\�6��j��3��u;�4D�:z͐��4�`I4���q�&y��*���h�g��|��Ӥܜ�o�4��~����Ƭ�y�C#v�KH��8�̰�T��� 8�P,בci,�|2=�Ϙ��J�[�1�a{�6Yȅ���sGr�����ט�sVJZk�
C�!�f���u����bd{�F�F��M_�6��R;��ۑ��̥I�F
.�	��$h��4/>w˻"^�B[g��Ra�&�_�MQ�:�į�!�b�gaDֺs{��U��6�e�<>~_o֚�j6��Ȳ�;GP���wG�E�a��,�,(D�7.� =R��Ã��|pt����W��r�*�?~,��D�09��������9�;|������7�S�T��͞ڜ��}*�c
���=�X+��W��Iy��L6ͅ������y�������QƓ��u���5��`�I3i��q
O
�B�u�->iك�áyFt[��L�^�b��48��7B�˽�cQ��qR�z�n(����[�&�b-���|,R`/�@S�
���w��!�Mk*��qܝ�(kGaҦ���^͝�T
ͦ#�v\������Iю"�?��D��'�M��9��°1/,dr ]��#�'vca쟻*re뙕L�:Vߟ^f��߭�u����'�8�j<�*�
i�d��k��?H�m�N
 �4��Mr�)3@��ҫR�S��#�f��K�2���:�ODO���ބVL��0t"��\dry��P��r@��t.J���ɶ�d�6t�v�,yf
t������vӅ��MHd�%�!�	N�7��%K�t�V�΍���f���^g�eױ�T~�d�Dn�'�r�&$���2 E��V���ҋ|��0b`�up�L	�ܠ��z�����L�RN���mc����F{���Z����X]�Xk�����O����c�9ckO�1d�k����h��kg^4��j�o�:�����hti]^��wi��ek��\��"w`O��n�P���w�"�X�	�D&S�ڝ�
-R!euЂ͕���Ö Z� �m۶m۶mu��m۶m۶������d�WF�^$�}���l�j�
 q��&5T*���dV#/�8/�֛ic|vƅ�f��/L��v��1����v���V���8�����x~5��z��b-߭�;vU�/�f��:���;�a9�<}����㔨��]T)�h�	൫�k��ȿV�Ս�81�P'�w4�Z�ܺ�4h�Y+-��N�l�֘_�W���2�ұH.�0��7�[T�c��O�l�1�=l��a�mo��"��u�� ��U�bP�h�rؠ����Rq�X���Cvu��ak	�m��eO^>�,�f5�o�
���ހr��P2�\��P��p��޹����8K��C��"�vZ������rw��cqrOC������*MW:��^gd-V��� YY�����T��:�
ߡ�p��ڭ'q*D��V�̂��ȩ���ߏ$n�df����|��w?��|���Y���j���	�$�j��җ`_R
�=N��B)�@�\?�U�O6W,��s��>K)L�XF%�ϣ�UA�O6,�_c���,�nY�&�O<B�$�{��ڀ��q+|%�d�K��p�PX��HM*y��T��eJ�OH����Y]㘏Z��2�$�N*�O�>J��d�_'���k.�� |̅:U�}�W�n�����@��f�^��d%;`���U�؝�\�i�]���/��_�r��N�Z�O�~�G.��u{�+����ۃG�_��1w�K�SDԏp=(�������V��Dd�:^��s�1;��͹�N�x.-
(I��l�xG¨ :]��s����	�$'yYF���:N7��f��5D����x����Dw@}K< >%��I$[��_��9�u((�� �L���i��,�
���1�*����4t(�= ��dq*�}�+��/j��$}����
J����vu����H+���ܮ�����h�>��I�}c��r�K�a�K��`Dj��G*]Mm��!#�G��rd� c�\�o�G����԰��(�QXV��)�t��>f�@V;\�����@�F���-4J��a�$$:��78��^OԲ�̖D�;c3e���Wkc��t6��긨u�s�]ߵ�w���C��|���	5�Q���P���N��P/n�w� ��S�fT���2�������Wҽᬞ������lU�!�C�����g��蝙	E��r(�xXݟbM=�P�*R1tdc��4Me�ܽ���_'^���&<�	#�0h�q�M�:�sĸ�B�}8W���1������S�i��Ra��dS�bF���$��ai�{�)��d��i�n*���:%��~�z\���5�G�:�w	����t����U l�8e׺��>�w��g{ss���%h�Ax��|�k�g��N2���^��3;2Gh�ɽ�}
<�����<�Y���8~R�Щ�|a r
�bg҉������GT��P5m;��o7�DĄu�#44lTm0�pց�H������+.T�pj���'Q"ń��$���l��*XF�	�VWV��H��e�imaƂ�T�ό�6�LJ�KN$/�J��8^z!�*�-+['�Y�HZz$�[/�Q;���^�n�o�j\��9ʴ���Qhuس
%��4t�,0@�X�����(o6�.���$O��,�G��4�7 �31+��<��;���ZO�L�ꅍ���a�z�]�hu���*�/�}8�qva,D#�a�X���$*N��הBJ��]ih/�|�N�դk�1��4Z
d�a���;���� /�|��P�~��֚�k��Bz.Ŧ���F�TS��Ix؃��nȓ��cPD�2t3fr/fku�Ne�3/A�JƘl��׫�k
V� �����K6 -#�g4*������7T~�ONB�
��-�6���C遱���oR5��,�?Ib�Q��Z���P/FEבR�
ޒ�4�qWN�*�xJ�s�uu3vO��j�)�%?��N�J�ur�~��rM���W0دdR�Y.����G%I>�|������)D1TU�O�/k4���w8�Wh����� �/|���XS-%�����sW�;M��.��J&�J��9J�� �"�"�S�F_0[�Hz@3�t�DR�������$Ks+S]�fg���Q+��f3��+\��UJ<�OX��r��S��Y�c
�bE��m��Z���K2V�����(�
��C�1M6��c#V-,��$`�%���S���C��kOGU�C'��ʣ���Ƭ�����F�ĕ;�GQ�!�QQ#����Mi��;ǘfh�l�b��m~����[���﯈9����V7���fgr�;�bƼs"]S���-)�QyɥY�hdƛ�"�0K���6�Y��@gq�u�q�:��kR��]��w�"Vf�(�9DM/�0Y.��|��-9Z�7$������Gv�@Ȥ-����5.$��,����>��)�H
�#�%a��yg�{]�Z�E�<���!}�[�OpXq�"��'iwte���>u��'��G�C��%;8)�2B�2l�a9Ee�L5u��dt��t�� !b�I/����+��C�<��^>�2KNx2�c%��؃P�{B��|�a��ޏ�n{��x��_X
�"8�+�Q�=J�j_�2t3֕�r�n������G����Zm�f���t���5Zi|;?P��pFK����;<T�pƹ A��2Gm�Am�q������¨x�X�\��8拖���+*O��i�tժz�ș7�f��9��.0�e`K�̜��-KN�~�Ci�����ݖ�K�܋Ƌ�(�yU�;�6r,S�P �q�1&%[ـR+�n
�2 *%�Ҵ�+�ܝ�d+�/;�9S,��5�O�{��
�R�,3^N&M1_3(xip��="��1�9�������g351Rb񨲟��7|9j��j�~[
�glel�7 �q�um�<m.���cǒZ�狅�$z�$�h7��:xd`��9��#QWҘ�DWV�Ȋ�����6���:��S���nPJ���߂(������� >�xl �X���3���C}�
�i(n�KI��أ�ֺǥMύMO����Z�

t&����M�*C�ED&����9t��$r�'���[��L�` �A�	T�C�y���~Ʒ�6m$�6��S��'@���7Z�]� ����,=t#/�7�� ���b)��
4`�Š��Z]E��d]�aoP`��Iœj�pEA�p7�����ܜQ�_\
������S�8zBU���g�
N*;��`'2�h��τRMB�w��
�Y��LÙw��*������Ys�/� L6��d!D��r��SJ�4Q�D�ey8�42pV_<�RRn#.`�#���5��*5)�J�6���9��\�s!깃�jv���VmZ.�nXXg��䘩>��Z��&ߥ�a��O��q�{�X+����G���/���c,��	�Q�&U\,X=�Zk�Pr�r\%q�uJ��$���w�ҽ���2���X��,�x'\���L,}�І���값���;�ʶ��:��zVħ�bN�J�_��]n����{�aƵ�g6K�y4M�ס�M-��
P��2�~L] �.�ybWr�|�{�I\�Bi�%������%	ҳyU�$ �ɱ�	�1_�hK.n9�/f�8)#�Y��4�9�4�3��D��]E���&�W���7���D��搲2b����ͺz酐��~���#��݊��)�
�@e��a��l�ART�£�YKt%�kF�zOtf��S�������r��S�H��ob�z.z�_���ɫ8�3Y���Hݣ�:Fy����<���b�����ڑ������i��,�͐�~���HB�Ռ�,:��T���)�!ђ�btz������oL�1��[0�����K�����04#�	�¡���ٖ1�ш�*�<��E!X�וɬ�nhTj濌��f�:�Y̽�y� �ݐD;�J�q�YՎBӌA"&�籖7:Z2��j���eb!�K�u���1H2m;~D�n�I����)ࡿ�@�;D
�P�@�uq���Kـ��Ӌ���7" 
U^O�JD�v���qI��\=$�ō��P��eNx�J#u���0�[���.P0�k���Pd�.6TGd
,1�R~�1$޾H��W���=-��������Pހ�T�Qh4�-�h�н
]$0@@����i�}h�,n�P��x��B��8����$�<Zݩ_�w��z��P���ODR_��^É�_��05/V8oѺJ���>o5�w��ѲQ�a��emlܼ݂UY#��[5R���cvG��w �g�r�أq�{{D��S�|���E����=�?M�Yĥǁ���k-��*�7*p��Яހ[��g��e#���D�gz�a&�%��ɱ�k���:�D��7��u�hE�ΟDF��^T'�,zq=?�ӹR��A��CV�>H��u���(��^��c��	�rԷW^1�31�7�獳�+����`��w�jO_�0�&�D#�4@��)���
�#Aƭ~J���v�Q��W���p��X��7��Kl�0�Pң^����Of��0����[6.��C����(g0ʷ�L�-G��5�Y�˪�e�X_�,@N6a���#�����5q��0��`{����@1��}A�ճ_s{K���ﳙq�UM¶��V�����G4�CP߷�	�
�ak>)�=#�y�?6'�����q61i#򍴱׌�R����`whЎ�M4�6��?�7w�?7�7��
��D8��U�@�pa���M) C�(Ԍ�B`d10;yOw 7�
���l���z	�~	���a�
K1����6�v?s=�x�v� ���f��T���:m�0�h�����G^�fI�X
:#r������^���P�	��>4T�̮"$V%��5]u�X�G�ԣ�������d���=�۾�Q��n|{7�5�-�?$��*fE#��&�w���&��]I!�k<&��,�����*�F�=?M�,��jI)����AWXVK�i,���,�1��?�5���/�S�`�����Ԩ��2�
������̴�(<3\����K+��jӤ�M�Y{�ٝ���l�7�F�5�����uǋO/ �}��*�v	v��Xs&��'���죜2��:2��g���ug��}	(��n���/M�'�t��fu2���D}����K�ʂ8&|u��|1�=���v�O��f}�Z�,���Z��y��y�����Iu�dh,�
�
�����Z�Hң
T*4B��((J&p�����$~@׳A%�(		w�;:E�����':.
0շ��*����e`�|�$�$Z�!1)6%���m� lR"�a�5*��Y�h��h�rI�
��9���(�z���O�V8nʈy6�,lHH�ŉ=A���&R̩�R��C?h�(�J�Z�Ga¿DI���=�1RP���&!Lo�s��?!�ٓҘ�0z��׼�׶��9$'P]����d�u�ȭEݦj`�X��X���<T��2a��p��D����qS��0��Q|�]�J�r81gH��p���k
<�M�:�I����`���Z �܀�`('�������l[�T�C�c�2
g��Q/��\����3����&�D}�ND}x�?8ÿ֤�dw��fȃ�m01��hݣ�<���=�~ҧ�Z:S`�l��9/_�v=!�1=��<�q�Z[��#'�qyp%�쁪Z \�1S9T������V����F'W�Ba���r��u|�X+6q5��#Vk���e�9.�9�P�v,�����[F#�%S}�	�&�t�@v�ve��ESPr)�	�.Q],�,��q���S
v����00i�S��#���!�������z�m�5V��eG�
��e)Sᱸ1H�QeM�@��gx�ԍ&N��Vs�O���H�9���#Hv���[�c)�|(+�ה~9�[IY3=����I��B�hOc�����{�+7>���_D��B�~)�PE��XHW
��25{�l��귋�NF� IVPf�'��"����A��|��϶as�K�!SgfGi���Ll�G�.~���Lu��wm!C?�gx�q_�*�m�4�zD��K��0r���gl@8"M���p�r9��0��GΩ���x?]����t�(G��R$/xeEǺ��MƼ���߳�@�3.��(�lR\�K���׽���!�}Ip�}9��l��}��y�6�ze��٭ML���4g��U��xi6�)��x)Yp�(�p~�*�p��e��2z�*�Yw�r�w�mY!����r�IMG��znZ���`ŏD+�c1C���g�TD�>�h%��2Xn������Ėɤg4IǊ>ZsH��@��(���1�p����V�� p�:�#�s	j�Q��y�:�M�VBH�CJ�B���XZza�{H:��z@����\�B�0�\*	v��J�D厥S�\�N�.k��x���!�MX#i2�Kӂ@=�'���*��c>�[��+�N�/��DG讈�Xi�'�
��G5���UԱ���g�Na�goԔd!�>B5��ǩg�k*�JK�!��	�*�T��ԏs��(��O邨)���䱷���P���I��0�8�@FN>Cj�r
�i�
M��l��(	��-�M�@��8�X$ˉ��H-�h*���Uu`���ܛ��
R����.�Z �'�4��;lݍ��m����ɞ�a��/O�i�6(�y���A���1��w����٢��HyPt�k��C���bI�ԨmHK���#H�,e.I�
��J�
�saOTl�셸�\9V�1@��"���Dj`f!"�(��dK�M��:LP��E(�*X��{�N-G�����bp�l(��[�N����x�0P��`�=F��K<p�­����y��{q. �K"���(�
eu�j	�K�;J=}��E��X�S��,�&��K�FԜ����[Iٛk.���aB�����
���a ������:�x}�
5,�ɳ�%�Bb7>�?G���J�ҭ�����"W4xR��|D0nb�����<x<��d�'-��F�E�bO�ht=,�ޢ�ﺧ&>�!_�)g�&���|��|Q���"N���\]O'g���/����������J�P��Nȷ�f=��y�|���h��:�Y�)v�|���4 %�͓A'�u�R4��odYD�@EJ��D�B�Jlo�f�i��(и�*)x�\8X$���_��v�0�i�i�Ռ�w��P��*���w\�&�.�kxs'CV��Y��>����L�*�Ey c�#�0	��W�&�KC@@��i|:N)���� OA��-���</|_CR��p*�t��^c����p�=f��#�l�&��3ŀ��̆����O�-:����F��`蟷p�������c�'m���E�V
^�Q^� :�ȋ�Ѱ�{p*�k4܈�@&��ykX!�T
��p
HA�����o\��g5�����e% 6(o4����~P�!Fb�:��Oh`�8���E((*����)N"*TQ ��!�{���*����U1�����02������Ĭ�&��:��mim�OVj�`�@�K�f^O��T6�EX��\����o:W���-	�bM����0���g�4R��A��
/ydvn������3������
?=����������ZL`�p�^�Fg�׶�uH<t=8-Y^]'�(ޑ��5���E-?>
!ݤ[@\�@�z���t�J����Vj�����H{�~��=����Ӷ�<��T���h�``Wډ_�ܓ�<|�̍��&�������܍ͯ�-_�t��#4��3��K��s{���z����o�2H,
�z��d|%�8<r\ͯ&f��AY<@)&X�8�; �Op��\�v���P���0F�Gg������ʜE2d\~+Y ��!5@`x��!/�X�s����*?o@��n�>E	4^r�9{����%C������a�a�.$���Y��Đ��If��f8��m��ՋH44c�~H)���;j�X�z�v�s9}<���v3�<6C7:'��+��2_�cDP#�9�@�(��MEjĦ
Sl���D�)��W�(.s�W������h�~L1��M��q ]��7l ob��
����iL�9e+Ģ}��SH�/�� 
+A�Fǿ��(�(���z�_��K��l0H���j���XJ��%����"v��qz1������$m���`J�� ��1	C���#md�i(q�W�Sb��ȿ��RQݥ���U)�2M���H%-XЍ��Ϲ�)ط~��%G]N��Q-�"YOX�0!�����w�d�P���.B�æ�^��J���,��R%��8������B�e��� ݤI�i�L�N
&K��Īc��,�N��j,�A���!���`T�.^-"�le/�O���V�� |g�_:�x�
�j"J(��,oˍ)�3�|��bRЂ�.�� ������w��'8�#�� 
��������������������������������r5�.  