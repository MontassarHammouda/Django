#!/bin/bash
if [ ! -e env ]
then
  virtualenv env --system-site-packages
fi
source env/bin/activate
easy_install distribute
pip install -r requirements.txt
# pip install -r requirements.txt -c constraints.txt
python manage.py makemigrations --no-input
python manage.py migrate --no-input
python manage.py runscript scripts.init
# Dev Or Product
if $DOCKER_DEV
then 
  #python manage.py shell_plus --notebook &
  python manage.py runserver 0.0.0.0:8000
else
  python manage.py collectstatic --noinput
  apache2ctl -D FOREGROUND
fi
#service apache2 start
