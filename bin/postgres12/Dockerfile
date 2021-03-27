FROM postgres:12.6

EXPOSE 5432

# Add wait-for-it
COPY ./scripts/wait-for-it.sh wait-for-it.sh 
RUN chmod +x wait-for-it.sh

ENTRYPOINT [ "/bin/bash", "-c" ]
CMD ["./wait-for-it.sh" , "[ENTER YOUR ENDPOINT HERE]" , "--strict" , "--timeout=300" , "--" , "YOUR REAL START COMMAND"]