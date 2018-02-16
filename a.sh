sudo rm /etc/nginx/sites-available/default && 
sudo ln -sf /home/box/web/etc/nginx.conf /etc/nginx/sites-available/default &&
sudo /etc/init.d/nginx restart &&
sudo /etc/init.d/mysql start &&
mysql -uroot -e "CREATE DATABASE IF NOT EXISTS my_db CHARACTER SET utf8;" &&
mysql -uroot -e "create user 'user'@'localhost' identified by '12345';" &&
mysql -uroot -e "GRANT ALL PRIVILEGES ON * . * TO 'user'@'localhost';" &&
cd /home/box/web &&
django-admin.py startproject ask &&
cd ask &&
django-admin.py startapp qa &&
rm /home/box/web/ask/ask/settings.py &&
ln -sf /home/box/web/settings.py /home/box/web/ask/ask/settings.py &&
rm /home/box/web/ask/qa/models.py &&
ln -sf /home/box/web/models.py /home/box/web/ask/qa/models.py &&
rm /home/box/web/ask/qa/views.py &&
ln -sf /home/box/web/views.py /home/box/web/ask/qa/views.py &&
ln -sf /home/box/web/urls.py /home/box/web/ask/qa/urls.py &&
rm /home/box/web/ask/ask/urls.py &&
ln -sf /home/box/web/urls1.py /home/box/web/ask/ask/urls.py &&
ln -sf /home/box/web/urls.py /home/box/web/ask/qa/urls.py &&
ln -sf /home/box/web/forms.py /home/box/web/ask/qa/forms.py &&
ln -sf /home/box/web/templates /home/box/web/ask/qa/templates &&

ln -sf /home/box/web/my.cnf /home/box/web/ask/my.cnf &&

python3 ./manage.py makemigrations && 
python3 ./manage.py migrate &&
gunicorn --log-file error.log --access-logfile acc.log --log-level debug -b 0.0.0.0:8000  -D ask.wsgi
