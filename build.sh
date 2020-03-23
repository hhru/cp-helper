docker image build -t cp-helper-backend .
docker run -v /home/anton/.m2:/root/m2 -p 9999:9999 cp-helper-backend
