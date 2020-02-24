# 
# Assumes this script is run as root
# Create local user anaconda, # Set gid and uid anaconda < 1000 (permit ssh access). 
adduser anaconda
# Bypass SFU ADSU setup which authenticates all users with uid > 1000
usermod -u 400 anaconda

# Give anaconda sudo access
mkdir /opt/anaconda
chown -R anaconda:anaconda /opt/anaconda
chmod -R go-w /opt/anaconda
chmod -R go+rX /opt/anaconda


########################Anaconda user###########################
install_anaconda () {
cd ~/
curl -O https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
chmod +x Anaconda3-2019.03-Linux-x86_64.sh
./Anaconda3-2019.03-Linux-x86_64.sh -u -b -p /opt/anaconda 
chown -R anaconda:anaconda /opt/anaconda
chmod -R go-w /opt/anaconda
chmod -R go+rX /opt/anaconda

# conda packages
echo "source /opt/anaconda/etc/profile.d/conda.sh" >> ~/.bashrc

echo "conda activate" >> ~/.bashrc

echo "conda info" >> ~/.bashrc

source /opt/anaconda/etc/profile.d/conda.sh
conda env update --file conda.yml
}
################################################################
# Add instructors to anaconda group. As root
su username -c "bash -c install_anaconda"



# Root
instructors=(anaconda)
for instructor in ${instructors[@]}; do
    enable_create_assignment "${instructor}"
    enable_formgrader "${instructor}"
    enable_assignment_list "${instructor}"
    enable_course_list "${instructor}"
    usermod -a -G anaconda ${instructor}
done


