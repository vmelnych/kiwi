# kiwi

Kiwi - open source test management system.
https://kiwitcms.org/


1. Set up a an instance:
    ```shell
    ./init.sh
    ```

2. Make changes in the .env file if required, otherwise default settings will take place. Set the `KIWI_DB_PASSWORD` parameter equal to the content of the `postgres.secret` file. This is a workaround until the requested feature is provided by the vendor: https://github.com/kiwitcms/Kiwi/issues/2606

3. Copy `config/local_settings.py_` into `config/local_settings.py` and edit SMTP settings
   
4. Spin up the stack:
   ```shell
   ./stack.sh -u
   ```

# Upgrades
 Follow the link https://kiwitcms.readthedocs.io/en/latest/installing_docker.html
