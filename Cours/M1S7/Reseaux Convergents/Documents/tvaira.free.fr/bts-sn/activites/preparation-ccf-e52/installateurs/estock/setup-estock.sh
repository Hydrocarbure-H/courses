#!/bin/sh
# This script was generated using Makeself 2.4.2
# The license covering this archive and its contents, if any, is wholly independent of the Makeself license (GPL)

ORIG_UMASK=`umask`
if test "n" = n; then
    umask 077
fi

CRCsum="2157529607"
MD5="f07c0b7567a355549ca786a768f34ca8"
SHA="0000000000000000000000000000000000000000000000000000000000000000"
TMPROOT=${TMPDIR:=/tmp}
USER_PWD="$PWD"
export USER_PWD
ARCHIVE_DIR=`dirname "$0"`
export ARCHIVE_DIR

label="Script d'installation e-stock"
script="./setup-estock.sh"
scriptargs=""
cleanup_script=""
licensetxt=""
helpheader=''
targetdir="setup-estock"
filesizes="8123"
keep="n"
nooverwrite="n"
quiet="n"
accept="n"
nodiskspace="n"
export_conf="n"
decrypt_cmd=""
skip="666"

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
    if test x"$accept" = xy; then
      echo "$licensetxt"
    else
      echo "$licensetxt" | more
    fi
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
        MS_dd "$@"
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
        dd ibs=$offset skip=1 count=0 2>/dev/null
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
${helpheader}Makeself version 2.4.2
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
  --quiet               Do not print anything except error messages
  --accept              Accept the license
  --noexec              Do not run embedded script (implies --noexec-cleanup)
  --noexec-cleanup      Do not run embedded cleanup script
  --keep                Do not erase target directory after running
                        the embedded script
  --noprogress          Do not show the progress during the decompression
  --nox11               Do not spawn an xterm
  --nochown             Do not give the target folder to the current user
  --chown               Give the target folder to the current user recursively
  --nodiskspace         Do not check for available disk space
  --target dir          Extract directly to a target directory (absolute or relative)
                        This directory may undergo recursive chown (see --nochown).
  --tar arg1 [arg2 ...] Access the contents of the archive through the tar command
  --ssl-pass-src src    Use the given src as the source of password to decrypt the data
                        using OpenSSL. See "PASS PHRASE ARGUMENTS" in man openssl.
                        Default is to prompt the user to enter decryption password
                        on the current terminal.
  --cleanup-args args   Arguments to the cleanup script. Wrap in quotes to provide
                        multiple arguments.
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
    offset=`head -n "$skip" "$1" | wc -c | tr -d " "`
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
				elif test x"$quiet" = xn; then
					MS_Printf " SHA256 checksums are OK." >&2
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
				elif test x"$quiet" = xn; then
					MS_Printf " MD5 checksums are OK." >&2
				fi
				crc="0000000000"; verb=n
			fi
		fi
		if test x"$crc" = x0000000000; then
			test x"$verb" = xy && echo " $1 does not contain a CRC checksum." >&2
		else
			sum1=`MS_dd_Progress "$1" $offset $s | CMD_ENV=xpg4 cksum | awk '{print $1}'`
			if test x"$sum1" != x"$crc"; then
				echo "Error in checksums: $sum1 is different from $crc" >&2
				exit 2
			elif test x"$quiet" = xn; then
				MS_Printf " CRC checksums are OK." >&2
			fi
		fi
		i=`expr $i + 1`
		offset=`expr $offset + $s`
    done
    if test x"$quiet" = xn; then
		echo " All good."
    fi
}

MS_Decompress()
{
    if test x"$decrypt_cmd" != x""; then
        { eval "$decrypt_cmd" || echo " ... Decryption failed." >&2; } | eval "gzip -cd"
    else
        eval "gzip -cd"
    fi
    
    if test $? -ne 0; then
        echo " ... Decompression failed." >&2
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

MS_exec_cleanup() {
    if test x"$cleanup" = xy && test x"$cleanup_script" != x""; then
        cleanup=n
        cd "$tmpdir"
        eval "\"$cleanup_script\" $scriptargs $cleanupargs"
    fi
}

MS_cleanup()
{
    echo 'Signal caught, cleaning up' >&2
    MS_exec_cleanup
    cd "$TMPROOT"
    rm -rf "$tmpdir"
    eval $finish; exit 15
}

finish=true
xterm_loop=
noprogress=n
nox11=n
copy=none
ownership=n
verbose=n
cleanup=y
cleanupargs=

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
	echo Uncompressed size: 40 KB
	echo Compression: gzip
	if test x"n" != x""; then
	    echo Encryption: n
	fi
	echo Date of packaging: Mon Sep 14 16:27:12 CEST 2020
	echo Built with Makeself version 2.4.2 on 
	echo Build command was: "./makeself.sh \\
    \"./setup-estock\" \\
    \"./setup-estock.sh\" \\
    \"Script d'installation e-stock\" \\
    \"./setup-estock.sh\""
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
    echo CLEANUPSCRIPT=\"$cleanup_script\"
	echo archdirname=\"setup-estock\"
	echo KEEP=n
	echo NOOVERWRITE=n
	echo COMPRESS=gzip
	echo filesizes=\"$filesizes\"
	echo CRCsum=\"$CRCsum\"
	echo MD5sum=\"$MD5sum\"
	echo SHAsum=\"$SHAsum\"
	echo SKIP=\"$skip\"
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
	offset=`head -n "$skip" "$0" | wc -c | tr -d " "`
	for s in $filesizes
	do
	    MS_dd "$0" $offset $s | MS_Decompress | UnTAR t
	    offset=`expr $offset + $s`
	done
	exit 0
	;;
	--tar)
	offset=`head -n "$skip" "$0" | wc -c | tr -d " "`
	arg1="$2"
    if ! shift 2; then MS_Help; exit 1; fi
	for s in $filesizes
	do
	    MS_dd "$0" $offset $s | MS_Decompress | tar "$arg1" - "$@"
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
    cleanup_script=""
	shift
	;;
    --noexec-cleanup)
    cleanup_script=""
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
    --chown)
        ownership=y
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
	--ssl-pass-src)
	if test x"n" != x"openssl"; then
	    echo "Invalid option --ssl-pass-src: $0 was not encrypted with OpenSSL!" >&2
	    exit 1
	fi
	decrypt_cmd="$decrypt_cmd -pass $2"
	if ! shift 2; then MS_Help; exit 1; fi
	;;
    --cleanup-args)
    cleanupargs="$2"
    if ! shift 2; then MS_help; exit 1; fi
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
                    exec $XTERM -e "$0 --xwin $initargs"
                else
                    exec $XTERM -e "./$0 --xwin $initargs"
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
offset=`head -n "$skip" "$0" | wc -c | tr -d " "`

if test x"$verbose" = xy; then
	MS_Printf "About to extract 40 KB in $tmpdir ... Proceed ? [Y/n] "
	read yn
	if test x"$yn" = xn; then
		eval $finish; exit 1
	fi
fi

if test x"$quiet" = xn; then
    # Decrypting with openssl will ask for password,
    # the prompt needs to start on new line
	if test x"n" = x"openssl"; then
	    echo "Decrypting and uncompressing $label..."
	else
        MS_Printf "Uncompressing $label"
	fi
fi
res=3
if test x"$keep" = xn; then
    trap MS_cleanup 1 2 3 15
fi

if test x"$nodiskspace" = xn; then
    leftspace=`MS_diskspace "$tmpdir"`
    if test -n "$leftspace"; then
        if test "$leftspace" -lt 40; then
            echo
            echo "Not enough space left in "`dirname $tmpdir`" ($leftspace KB) to decompress $0 (40 KB)" >&2
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
    if MS_dd_Progress "$0" $offset $s | MS_Decompress | ( cd "$tmpdir"; umask $ORIG_UMASK ; UnTAR xp ) 1>/dev/null; then
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
        MS_CLEANUP="$cleanup"
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

MS_exec_cleanup

if test x"$keep" = xn; then
    cd "$TMPROOT"
    rm -rf "$tmpdir"
fi
eval $finish; exit $res
‹ À}__ì\ûvÓH“ç_ô…â$³–o¹Æ38¶^b'Ø†ã´¥v¢‰,]BüÍ°Ï²î·¯1/²²UİºÚÎ† {Î’XİÕÕuıuµ¬v©üàŞ_|íìlÑßêÎV%û7~=¨nìÔv¶w¶·7ˆngg³ú ¶|…WèÌx`y–İmıÿO_¥òdæ¿·Í’áŒïÓÿÛ•ÊuşßÚ©ÕbÿomVĞÿÕêÎFåTşöÿ½¿V”œsèÌú/Ád1ŸƒÏ½Kîá:cë,ôX`¹Œ-›—ñÆÁ`öOgœ[>.¸w¼‡İ¨e2´ğ7—J$>àÌvGÌwJ<ı¢$ÿÏri,D4Êkl15Îøÿg¢é‘˜mƒí:g1	ŠÃüÅaê¹g›€N§®ˆÁ½ĞIÚ?XÁ9hÚ9·§4éNÊÀ¶ü µ vÉ,›lğe)†ÀÚÔ³œ@3ù˜…vàK™9|8·Œs°øà†¶	ÌBo¡crã9ĞŠ-ÍxàzÀ¯¦6s˜œ™`óyL÷Êe“_–„K†;)›nlOî”¥{4æ|¢]2Ï"QıÒy0±áQtÉM3B;0ßç&ÉH¶<À°-î>’¶8g>Òq<N†"Z²!ûàz&Šu.ôA^Ü1l—¸	ã–qá—ß‡nÀ‰÷ò—PÙ“fA³PWT0Î™ç—JÂ|Â'#Œ0”Š›h±L¼˜|d1‡‚ŠRá0çÌB“S}×¸@GÙ®!LV"mŸs*Œy÷aŒfõİ	Çá¹Ü‚}ìÚ¶ûX^2;Ä¨iˆô3ësv‰A…3p†‘°Që T”·&‡>ówŠ”âáÃ:”Ñøe/t"Ñ”Ç28ÑT’áï„Û„}æ£T}(J¥P´© S¦–©Q²]Ï)î(y”h66*Û
å¶i‰™Ê¡ï)”ïñ5ñ°­‘¬“iÜoÛĞ&Ü÷Ù÷5j—ãË>z”G#ükªñ«€{³5tĞê&ôm;¦Ì¤´D0®.b—FYDtÜ”„èx×Á@rä@î¶Ï]tH”b>L\t:&Æã€Ò”Kp ×ù”JFèa,ÇÔ˜izØ(œQÿ"GX%ƒĞ‘¢^ğÙpÇÜúÖ?…ïªÛeÂ®†Œ"†›Ã)F—Á¹‡z1³Aü¸ö"n4˜qÎ¯:ìÆ™‰yf3ƒû2¢qı	Â)ø†gM¡ÄÄBLn÷DnSF9œ›ÜD.4nl!¤`
bÜŠLCO íBk*“™å³‰æqÃ%œˆ!eØo4_œ++¤æ¦Ã¨+²ZAÛˆ)¥
yÕa{;#]-ì!"Ì’¡‘U_†Ü›ASof—ìO}‘ulkb	[vrÍ£4´d{è	 õĞ„–3]}ñ(FÂr´²0³ÑLØËğ\ç7wDè³áòAØK®èÛÅ`œM0˜rAdÂƒÃÂ(÷hXÃ§Ş*UPĞÄ±D{b€Ì0É%”•3îpÙCìR2§ÉTsÏ’õ‘0¯sc oøªĞR÷<Ä6êÕ2 |IÖó1 ÒâB³rA½0Ÿh–óÅàëC‹y‚PT <÷D‹¬™8’&ğ1'†ıÃåziD#'#Cégµu¨	6ZÄAÃÜÕB=¬aÎò+ZS ›¤D•CZƒpÙBbˆŒšÁS	™¢«<±xi q¾G¹D*Sø„‡±,1ø6®Ea’ŞhuôRK,LÀFn +ùÂ¸Ãe,ââ¶”„R•‹-÷Ñ’m™(¤ı›>¼ÎpØ)ì†‚åq
	h²ò)„dºˆÔÅT‰ZMwhˆ¹…Kvhòa\Û6á	™uæ éµ”"÷Úã¶ö#8§·rÁ¥ğƒ¸ˆ†¢töE5)"×ÿüòR–5 3Eê`a$¼%P=šÀã¶Èß¸ö£HÀ^r˜=Š$ëĞ[Á8òeÔÌ1/¢/Übì÷Ì	Ğ3ëÈ%zók`9©ÑdZŠ0é÷Áà^@eJçCe'îÈù¦Ü!¢g'mPqÈÌ`ª¬ö|ßÖVÏT:wÈª4å“¸/³QĞÌQá2µ„[Í§îÿ¸àZ­]VJÕ²»¯ıßöæ5û¿Zm»ïÿ7·*;5ÜÿÕ6k›ïÿ¾ÆKÓM£z”ê00±"øó_ÜßƒS®‰¸8ÅnEiõ¡Õ4ö}Ú ¿n÷ı”ê‰¢4%zª{4XFy‚½Ùk@ûÌ—Üôşü—Äl3%a€š¬2Ãøó¿}øó¿Àf0šS¢éåx)9ŠÕƒU™«OWÿmÚ-½;h´õì¿ÕxC´ú„F=ë5ºhÂq¯ıª}¨?ÓûpÔM5+ıƒ£C1îàğ¤ÿ<3æ¯€Æ÷/4şHKTXTppzì¹ˆÀÒ‰‘šèÃïDt°¦ œZf|‰›Üµju]vOPÕÆÉàhØî"«š¦HÔ]wrŠû(vwkÛ›)1õ¢šFï¼ĞßÀZÊx]Y½û¬İÕëØ·ôƒÆÉá šÏ½¾>¨‡Áx÷¯Z¦İE İE7¤
×áUãğDï+k«sb9¸á@€ç¡·º^Ä¶gè4Œ'‡áÊ+[Nw%É½ºì™ç†S~»Ë"ºØeñåwYÄxúšGİş ×@‹Â‰caİ6”½pÒm¿<Ñcã~}ï&Æ˜÷îqïè@ï÷õ“ôcUÛôµ~W^’«{ui&xn÷k–8vn®í.¾>…‹7‡Ëíñ™Ä	Z(è+f[¦àXò|ÛÄ
PX…¥\j[[ëIœ$¤7hñcºuå>3Ï2DÕí9¡ô	#s,`IÜgmÁ‚Ş]ş¢4¤(	“’ÇÃ*õôö³î6âvã@ïéİ&®'²-×‹KLK?Ô1|š~³ÑÒo§¶0OœĞÙyd[®wa»fu.1óÑœêQL§*Šx+ÆqUÌÇO1.ÅlD#K#çÆiY¾Z?¯Àşœ[¸ëá»Z¥VÕ*;Z…ºA?şİoš†±1Úblg{ËÜ®š»µ“vwkÆøñc$ÁÿÁ%q{:ö8/Å*ğhZ»›¦Rö»©ZÙÜŞ?ØÒİíÍİÊ÷®ø>gáÄu|ûÜs'|^õßF)…ü7<µ™Ïl›ïn–\ïì;Ñk¤¬Ÿé=|sLåZÃ	\ËYĞÎæggÜ+M™Tm·S]bğéƒèÔE ŸÜ1ÆÒbŒzÌAlJ¿I]*µ}½‚›ÃïO—ı£“îQ›œsÀFwæ5¹¡ãZ^i,Ù¨´ZÇß£SZú+Äs‚Ë1¸HT¤’(bòKŒ¹Ò¥Ôc»ÖØ8ØÚ®DzÜcÁÔğ&h¿;Á1a\(%×·×5¢ŒÈ×-\ŞƒÇÊÿ¶jÃ5™‰é/)ÇbâİeÕt,àúg­¦©ºVq|dÅ/f$Ì/‹úÕÄM²ëcÀøäñ… ü‹Ó47èW‡ûtCî>æ èmĞ/ı}hMù$
Ş{ËÁì.;3AG¤¼øâ»2Áöl´"İæ·Y/ˆUÓu|w2!«İ÷ŞÊ!¼}W%È’ı”¼úâ^‘|¿[bõæıÒáA|ë#~ë†Á=;K,Ó‡³ìÅÅÙ=;0ˆ$¸İw	eì¾´á‹{0aıœ˜Ñsá&Uh„tO#Ü	hûçšÉ÷™çİw¦5ÄGÅwX“%]²$G—_ÜUãoà¨DÃt0İ"·ô]/°îİ'8‡aß©P’„i¡]ßínÒòULŞ8¡;#ñÂÀp²–_“sKÁ]Ê0Šç[Ê4ëL>1u™€±ëd^,Ë¤9æoÚDíËoØÈ58{…Z2=_æJêº˜sQÚ°Ùª˜·I1Ö=_‘½²|ğ­+˜2ÇÃãátj°;™Èâ¾Sûqwµ[•ÅBí‹Müù?cf[é€}u	P­eæ¯Ö¾‰	¾’TùØák£"ªò­İÍÇ[TJO¦ÜÃŒEø‚F³Üj¢ÕÊı
Qİ¡»MÕÚÆ&)ÚôPU+8³Pÿa³Ÿ~´yhJ²2£«»æÍÑğ·x[‰S¼±„½/CÜÚåºcœ©Hµü©ëĞcs×Q˜w-ŞŸ"ÆsÏ•{²åÌÃ«4 Wú¼uá6z7Ã1½›g™Ëå¸œì±³Ğ5æûo»—LR[2I´bä'ùş;O²±0IZfg‰[ç(î<ÏæÂ<Ñ¾%;‰hÊö}™Å,N©Ü¦?µV1«R1™½˜†t1½E¨Å¹PÉÍVt¯‹x—îb­_*t÷xŞ¾®p5)Œø›ù©nÕ*Ën˜|}ËmÏY®[NwèÜqÃKQ=ŞĞ)iŒÒ™–ÛîğájñFì/Ş¼Å)&ÕqLÕÇr›PLö× vnšç®çÒugÑgªâÊ›@7µÄ<v&=Ëñ3÷ÉgÒEºÛà'7é"FKDv:Ñ”íû¤)Ñ4Ş0æ[´åz?èşJF|»ó_>Â©&ŸR*ùç_ıüßÆ6ö‹ÏÿmÑ9±jíïó__ëü×£òÈrÊ#æÓÁ¦¦;Ù|ÀZsj•jEÃ_Ûô|ïOÁåÏâ)ÖRyÂ.¸Ïí1äÃ¢	Ô¾<Ö`®ZZÚ¶åƒzÑ3rêâˆ…)hƒo]ò¡iyâ=”Œ‹ÅˆÛñÑ‰¡ü° ÅSVVèùdñì~t¢*ôÀÎÍ­t½®Ê	Uå•Şë·ºuµJÇBT¥Ò!­ß"¸rØn‚ÔÕgÇ‡ª‚+‹~Ò««ÑÇï >'£e?9ÿY%ùn}I-Ä\é´ˆï‹¶>ü/DÂpOiôšÏÛ¯P€Ïãjò)wL:áà£.ı>léûu5zh_<RüyŒÇ–AFğ•şËÃáAû0±uòˆ±ªtŞ¤éùÓO™od*ÏúéËäxJÏ–öd#=Ó­*Ç~ÿG½V]ŸŞT•Ö~±/ï>­‡Vó*¾|EËNs0<n“âëV¡í-«Ê s,Úé4Õ§Lè†¸ÈúJ³1À±”©C­úz+ºô9*„uâ qTœÌ¢¾(V@›ÀöæfJvÜ;zÖkt–Sîlm¡…ô„u{ĞÆ²U*7zØÚ|ş‚Z‡²$Ë0Ğí ™’‚¸]G‚L:/RÆ“JuÍ„m£J!„ê¼èã„(àdIÙ˜Vö€ö^q=Lò„p^ûgp9†ÄWqãÕåİ‚OQÆ¡#êªÑ0ÓÃi0|ZÁÚ:(¿c1…ØtPDrÁÏ@g9ËNˆ®ıüCUy¸Âs4ê¯N;/ÌA*Îá‘JDWV UåcnVšKùNĞt+ ”%\”—‘ö1LÀ/Ôlá-hW &–—çè
¿Kû}$¹´SŞypÎEn$¶-¬ÅÄ¢á#•1ı±\¨”^‹×º
ü‘Ø8šÛ>_d”[KÄ¡ç³°*ë¥BAF=‚Â\ğdÌúÃxqtÒ|~©…­ó-…ş˜ô¸¯5
É¤õÓÂï˜]å	TÓ¹OC3Œş€4`=Pßî…SD½w*½§câ}vÈibõÂï+ÙÙ>¢ÓßCEÚ9kè›„²ı‘v`$Ô¢´Ğ:½ö>¢x¿ÙkpMË
n„”‹°ª®b¾ÕN#c|I)]ÿv!{ú`ğfHğ»L¸:
§-n›~½vô	ÁiÆ£+T£ìÿÆ<Ç‚^	tËa®šü4òøS‡¸œaoÉò&òg¸Çí_ô^áˆÎ¬NÀÄïê2€üáâò‚>½°¹È•c±q¾®Ïşv\âUŠ[è£óN…ìOÀt#¢¹çs¡½Rs¥oŸä-‚W½À¢é>ÓuDŠ=o¼Ò… t{!½wĞÀê„øD^–ËEÌ2SdgÎM—°«F)Kä0=jƒïø°ñF…GuPEr¼"š˜¥
‚FcØ&TË¡…Ô¢ó\N®è03¤ƒê¹YBn€dn©¯ÁÁ…ŠŠğôßÕÂSõcÎºøz›Jõ:ÖOsõyGx”Zéuj£Œ¼JªE<<ÓM½åO!áC¡$‘­§*Î~‰İ#[ĞJ£¶iµ3ƒÃ™Ç¦çâƒ‡Ì$w„`-şˆ˜Â¥eòuZŠrü03”êÑ\t_EÇÆïã‰À‡É÷7 £&¦¡/&H¸OOQ	/A, -‚{Áf{•8PÄv„ö=!Á±:ˆ6ˆsù e&mêbn=ğB6?y½Ç|YÏË×qKx¤ˆ‡Hê-áFF»•¤æ>3rÅƒ8{KÕõ¾D|¢E¢^ÖŠniÔ5·å¸TYÈ8Š1Cu.H+b1)Ä÷L®QboÊNùı;È&sZD,P»åîuÖßtL4Ÿh«ĞƒŸ~¨æåVÒKÊ¥È¢£(½å•%¶‡Qá9PY6¢›áäGT—x™ñ>‘Ö„WÕı·•‰*çâ9b›sI„¼^‡O÷@ë°î†ÖFGÄ‹åvNRê×ÜÛ7Ê¯¹AqVª(Ï^¥ˆ“îU‹Tb#í^M'“³Ğ:ÌÅ`JÕ«~É:¡Ğæ¨EF'ûVíÛ[bÙ×?Ã°úÁm–EŠkM+Á0ÑÖh2xD…6ÄywD =òP|ÛD+€¡-:`Ê±ì¢µ4$?áÚ}EÅ°ÃŠe¢¢¬SCË¬WÖhJ¶PƒKjQgş"VĞJ´ÑX‰Íµ’¤uş›ŸlTŸT'z¯§Ÿôö2³;<Œ>«¤#hß}°y|T¨ğ(Î¥Ü,ªú$¹ù%/ãZ²Ã±¸\.—`øF¯Ûî>««¿*ÑÛ=aòhKGçÅão¡/+É¯Yğ,ÖÉ&”837ô@~›Ï#ÁáÄ_bB‡Õİ}7é{…Æ;ÁúWŸNÆËÛBEAæ…Îÿµw¬MqÉûšù­êlKËlW°IB çR‰ñÕaSuå%¬@ZVf_'im°Ã¿î‡f$íğÙWÑ¤âZ¤yv÷ôôkZtÿ<‰ÓKAã:%)ÓJ2~C÷ÇIQr„÷qÇÜ£Œ)Ù˜£ÙI‚R‹ç™ıe.%Ë–F nLgh¤ãÃø¢ŸA• );F,¬$CêÂXšÏŠĞ	0ÙÆ­uJøD©=¢« odÊì0*[Ó¨\ı`’Šµaf Ìíà+øH ¯sJ²"¯å DjTn•`¢³<¤>!ÿÏ!¡¥³,AÜEÚÎù@CÊio~İwŠ¯åîÔ±Ãş-sR J ŸƒYìSÑÓå!øò ¿Ê:NÖ1!‚#x‘)>F´¯)»	€^&ú ‚âqÒ¢0	}ÀÜ®L”2Ç£L§¹X“.)sO_î:ej[§½8 M
ß1k9ÿGHŠï€œ)ST<‚}L)$ˆl$eL’ø=H]@·ŒÒüHk•I 'S“>æ}
c@>€àæíÊÉØ@îG}LÀ*H82à
v>G‘™« ‰²½¢Z"ôµ)œ“¨¡p/6¥1ÏRaà\$'ò„õ¶A³Yu¥\éY§ÓpL”Ugö†àËÏĞ<õoıcV[“ÁÛüüt”“Úüõ«ıWÌR/••ô×ÃÓ¼zy€š=/³Œ-;Ÿ¼DõœÈ¾]†Ìæ@Å’V(Ä¿•m´Ğjùip}Úƒ±:ñv[pÚ±%«ô }_ò„06×½²ôxr¹‘cÌTƒc”¦äŸ>òé(²WBa¨^ªkV,tÿòàèh÷—ƒÑ}„é_È¿I®¨%Œ‡ÛÜES;’zƒ?¥·‰\à©ô9±İ)úÒáp'±ßãs<gáô6åT–(îeQ•œ Ã7,¢² &1Ày÷(¢†} KáÀhÒ~Ü#Y szT¾9åĞ°+ëx“áUÊÆ #èş·Ÿw6”}L¥r?=¸&,–oóAdV*/0ÅwĞåÊÑZ.õò'Àî`‘ØL[oÿx»FÓáöIÇïœv¼Në¤ÕºhæR{Ù˜LÔ càî 4Æ|õ'>\òæ'Ê÷Üúğ…÷İúMƒP6à^»«;7×Ú^’p×xÄr7¤kšî4lñöÆæV7§oç  %‡*Á&å(…ÓÅjtù³cíÙÄ0÷àDupKÒÛnØãŞ%jDù"«À°	`èæsru7jlq˜“ò. m^ï„[Dj*Ì‚©Uò/¹ÃĞ¬.!/åKx—¢Aøpôù‹$Â!ˆ¾Ï{ò×Oëü ö‡qæGáôáH†ã0’æMİD°•š\éâÂå;E6®»(ÍgI\–­¸¹Õ¥!­- (˜\^QNZToJJ‡	ºäOƒü½à<Ü·¾o#ÑÛËøâ·tk=‰åOÔñF5¹ÔÁ¤GãhAe…cºV~]eGHÓ(¿QŠ,øãIp]ò÷5QTâÛpQGİù‹&9F×2˜Ï1q)e8%G`4£ô¦:[kªÛ+i“ÚaF6€~JS vQ>78öÏ¢ó óÉvı&t„¦£kİğÏóÇŠ¿KØ MÈ%¤ô`Ne•Bõœ‚¡ıA	±C µD>H “˜V¤·:Â¥/v˜“VüòŒfPÃŞ ÂÔ½@
=Ôá*)ƒÓ¸
à¸QêÇÉ´M(:~K¬=ãL)aÀ-À»¡n#ø±z±ã¾‘RåB®tªƒTñê,˜ÀFm·µ½"àÑLKlQfavE€‚ctã0-V{= ¬
Ÿpª|tšëï!©‹ÑR™FÔ)ÃEdö¦®Š ô¹*n‚{}WZğç\\vjÏ<dÍÙ¢7Ö»lüÒÉà?Ó¶òV}NJòïÜ®KÔb×›Øõ«ßÊİ6ò cÜŞ—Ü¹T½¨ãÌJ°&åág§pxòCîù®@¾•»»’ŞœÒ"o5}gõjÎlú¹İfec{ ±œ‡íŞ‡/%u+°Ö2ˆÎ›(8Y£H®€£Uõ~·u¿s¹ıVüü›¬D¤+ì­†ÑC8ŒeN¿ÒÎÛ=ÇX=Ô#1Ï(ñô|…š‡[òE–÷QÏï1(æ®¼i±,%èXª?è’Wßv²ãOîhS¾™/{G&Ë³]Lk:CÚÆœK“ï„/íUü3-G[¯ÔI¹ƒ>ˆüÉÆÆª{ñW„¡;2„/4é•9Ç×qÍŸ–¢o$^¾Ì«ùùÖ^›åFKLQ·Í_ˆè\ì{{Ô°ÿà]cV0ÃŞupĞ#'Ş8sF²ÜçjX)
W	Şh[I—–½ó(å²­U-;°'mDøŞô}m|3*¸RPë£w5E—·ÏÇÓAôÑ{OË€>P’ÄC (±I¤mˆø!=ÑÜœ¼ŒÅ¯	S0›Ã!u„ƒ=Â}ß×ZI*.Ur~>ß”=“.bÌF”’Y
è2‡µş½XÅy”	§xaÑê"œ.æ?‹õ“yİ/äÉ3#‰>é Ö2„+c›g*Îq4ÅÏ|äø™oøuÊ2ËÁU–çÙ\j€ÊåàÊäØ°*oÏ\)¼ßÌ‘+tÂfˆ|fÑJ´ÖŒpÕqİÒÊÄ¶*¹İƒ:|'j)‡¾·¥Gqr“J¡†y‚UëÕú—F¦Â+ºK±À1»cÑ:òŞÓ§O«k˜óµ°»ú¡—Sûİ>aÆ<ÅO×ÈãB~¥Ã/7MqsëÓ	æGsˆ>Oy…t+ºPÓJAî1+Ák=G®-Oy´ü´/¬ş¹yNqä0÷“1ÈÑéãoZ®Jx·tŒÓóç^œ²U}‡YW×ŠK…7/¹r:–Óş
ıøøĞIÆÇ'OZ1YŸ3eç>ôb¢'H¿†ŞYLàiO6å¨‰„ßP»ª+ìN&ÓkàèèyDÇ¦øæŸ`ôÃ¹ö§|ïõ¿~®J/d Ã¬˜Hº=q@‘ \uæïí¾6oT˜ ·‚Òò›.òuU]@Úa¯*{*
&û6…òB“
¤­;òÓ¹ß“û6NOrs±(é†“Ër9¶­(i©}4ÿˆãf·Y¢­ĞÏˆ'i®ñ¬ÒÃ{}F“™ìá«¨¯Ş®j/"3v«ïÊ­cî2ÖGgäàÕõ˜i“×˜şg RlÆ]¨^°DšĞ¢÷wÁlug†t\®p;t+‚’Ct4î¹°Æ7/ƒxtÿıÒç}â,èb?ú¢@@š.»çØäßñïyû1Ú©_s ;P8´cL‡—0–—b·ûÑ0HvDS´}#wm4¤Çèz}«úÜôÍ¼²šÓ5wE[À™îça¹#ÍZÑ²Üa³r{ókÃÒ?tõ"U,¾|ÏíFİç04L¼¨Ä­AñDv&c…¾úïÿ˜ßÿUßÿy¼¹µñ7Şş_L®şşï—şş¯ùıgùıß­­Ç„ÿÏ?¹¿<ş¿tşûûß"ÿÇ“Í6áÿóOî/ÿºÔ¥.u©K]êR—ºÔ¥.u©K]êR—ºÔ¥.u©K]êR—ºÔ¥.u©K]êR—ºü—ÿx@?t    