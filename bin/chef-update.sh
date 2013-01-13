SCRIPT=`readlink -f $0`
BASEDIR=`dirname $SCRIPT`
chef-solo -c $BASEDIR/../solo.rb -j $BASEDIR/../solo.json
