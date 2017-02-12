Thank you for your interest in FB datacenter data sharing program.
Please download the data from https://www.facebook.com/network-analytics. Here are some FAQs.
1. Where is the data from?
The data consists raw fbflow samples from 3 of our production clusters.
Cluster-A is for Database, Cluster-B is for Web servers, and Cluster-C is used as Hadoop servers.
All three clusters in from our Altoona Data Center.
You can find more details about our topology in https://code.facebook.com/posts/360346274145943/.
The sampling rate is 1:30,000, uniform, per-packet sampling.
2. How to download?
Each row of the scroll list is a URL of a data chunk in bz2 format. And it can be downloaded by wget or other downloaders.
To unzip it, simply execute "bunzip2 <the filename to unzip>.bz2".
3. What's the file format?
After unzip, the text file is in tsv format with each row as a raw sample in the following format:
timestamp
packet length (1)
anonymized(2) src/dst IP
anonymized src/dst L4 Port
IP protocol
anonymized src/dst hostprefix (3)
anonymized src/dst Rack
anonymized src/dst Pod
intercluster
interdatacenter
Note:
(1) FB uses TCP segmentation offload, hence packet length can be larger than 64KB since we are sampling outgoing packet in kernel.
(2) We hash the content and get a subset of the has value. So it is not guaranteed to be a 1:1 mapping.
(3) Host prefix is the prefix of hostname. For example, a machine "web102.prn1.facebook.com" has hostprefix "web". It's a very rough classification of machine types. But notice that multiple programs can run on the same machine.