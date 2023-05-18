for node in $(cat drainlist.txt)
do 
  kubectl drain $node --force --ignore-daemonsets
  echo $node drained
done
