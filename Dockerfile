FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

# CMD rewritten for clarity and Render compatibility
CMD ["sh", "-c", "\
  python server.py \
    --port ${PORT:-8000} \
    $( [ -n \"$AUTH_LOGIN\" ] && echo \"--login $AUTH_LOGIN --password $AUTH_PASSWORD\" ) \
    $( [ \"$CUSTOM_SAVES\" = \"1\" ] && echo \"--custom_saves\" ) \
    $( [ \"$VCSKY_LOCAL\" = \"1\" ] && echo \"--vcsky_local\" ) \
    $( [ \"$VCBR_LOCAL\" = \"1\" ] && echo \"--vcbr_local\" ) \
    $( [ \"$VCSKY_CACHE\" = \"1\" ] && echo \"--vcsky_cache\" ) \
    $( [ \"$VCBR_CACHE\" = \"1\" ] && echo \"--vcbr_cache\" ) \
    $( [ -n \"$PACKED\" ] && echo \"--packed $PACKED\" ) \
"]
