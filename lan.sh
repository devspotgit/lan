

#----Local area network with three nodes---

# $1 new for creating new lan
# $2 network id to identify the network
# $3 number of nodes

# inital IP count
ip_count=11

# all lan id
all_lan_id=pat

# current lan id
current_lan_id=""

# number of nodes
number_of_node=""

if [ $1 == "new" && $2 <= 9 && $2 >= 0 && $3 >=3 && $3 <= 6 ]; then

 current_lan_id=$2

 number_of_node=$3

 #check if the current lan id is on use
 for node in `sudo ip netns`; do
  _all_lan_id=`echo $node | cut -d "_" -f 1`
  if [ $_all_lan_id == $all_lan_id ]; then
   lan_id=`echo $node | cut -d "_" -f 3`
   if [ lan_id == $2 ]; then
    echo "current id already in use, choose a different one"
    exit 1
   fi
  fi
 done

 echo "creating nodes..."
 for (( i=0; i<$number_of_node; i++ )); do
  sudo ip netns ${all_lan_id}_node_${current_lan_id}_$i
  echo "${all_lan_id}_node_${current_lan_id}_$i created"
 done

 echo "creating veth..."
 for (( i=0; i<$number_of_node; i++ )); do
  sudo ip link add ${all_lan_id}_veth_${current_lan_id}_$i type veth peer name ${all_lan_id}_veth_${current_lan_id}_${i}b
  echo "${all_lan_id}_veth_${current_lan_id}_${i}/...b created"
 done

 echo "creating bridge..."
 sudo ip link add ${all_lan_id}_br_${current_lan_id} type bridge



elif [ $1 == "clear" && $2 <= 9 && $2 >= 0 ]; then


elif [ $1 == "clear" && $2 == "all" ]; then


else


fi


















