title: iptables
date:    2012-10-19
category: linux

<img src="http://tuxbrewr.fedorapeople.org/tuxbrewer.png"
alt="tuxbrewer"
style="float: right;"
/>

This is a simple way of logging all new outgoing TCP
connections:


    # iptables \
      --append OUTPUT \
      --match state \
      --protocol tcp \
      --state NEW \
      -j LOG \
      --log-uid


