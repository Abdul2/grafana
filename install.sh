# to install on Mac
# still working on it - work in progress
!#/bin/sh -x
set -e
pip install --upgrade distribute
pip install --upgrade pip
pip install ipython
pip install virtualenv
brew install cairo # depends on glib 
brew install py2cairo

#Django

Web engine: pip install Django==1.4.5


pip install carbon # depends on zope.interface, twisted, txamqp 
pip install whisper
pip install ceres

mkdir ~/build
cd ~/build
mkdir graphite-project
cd graphite-project

git clone https://github.com/graphite-project/carbon.git
cd carbon
python setup.py install 
cp -r /opt/graphite/lib/carbon* /usr/local/lib/python2.7/site-packages/
cp -r /opt/graphite/lib/twisted/plugins/* /usr/local/lib/python2.7/site-packages/twisted/plugins


mkdir /usr/local/share/conf
cp /opt/graphite/conf/carbon.conf.example /usr/local/share/conf/carbon.conf
cp /opt/graphite/conf/storage-schemas.conf.example /usr/local/share/conf/storage-schemas.conf
cp /opt/graphite/conf/storage-aggregation.conf.example /usr/local/share/conf/storage-schemas.conf


echo "STORAGE_DIR=opt/graphite/storage" >> /usr/local/share/conf/carbon.conf



cd ~/build/graphite-project
git clone git@github.com:graphite-project/graphite-web.git
cd graphite-web
./check-dependencies.py
Install dependencies.

pip install pytz
pip install django-tagging
pip install pyparsing==1.5.5
python setup.py install




cd ~/build/graphite-project/graphite-web/webapp/graphite


echo " DATABASES = { 'default': { 'ENGINE': 'django.db.backends.sqlite3', 'NAME': os.path.join(STORAGE_DIR, 'graphite.db'),},}"  >> settings.py

cp local_settings.py.example local_settings.py

python manage.py syncdb  


~/build/graphite-project/carbon/build/scripts-2.7/carbon-cache.py --debug start

~/build/graphite-project/graphite-web/build/scripts-2.7/run-graphite-devel-server.py /opt/graphite