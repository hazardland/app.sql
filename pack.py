import os
import sys
from dotenv import load_dotenv, find_dotenv

# packs sql files in one file

load_dotenv(find_dotenv())

output = 'pack.sql'

files = [
    # site
    'site/schema.sql',
    'site/tables/users.sql',
    'site/tables/user_profile.sql',
    'site/tables/sendmail_template.sql',
    'site/tables/sendmail.sql',
    'site/functions/sendmail.sql',
    'site/tables/user_token.sql',
    'site/tables/user_token_config.sql',
    'site/functions/user_token_generate.sql',
    'site/functions/user_token_send.sql',
    'site/triggers/user_profile_create.sql',
    'site/functions/user_token_verify.sql',
    'site/functions/user_email_verify.sql',
    'site/triggers/user_email_change.sql',
    'site/functions/user_password_update.sql',
    'site/functions/user_token_valid.sql',
    'site/tables/debug.sql',
    'site/tables/user_session.sql',
    'site/tables/user_media.sql',
    'site/tables/user_activity.sql',
    #admin
    #'admin/schema.sql',
    #'admin/tables/admin.sql',
    #'admin/tables/admin_session.sql',
]

if sys.platform.lower() == "win32":
    os.system('color')

class color():
    black = lambda x: '\033[30m' + str(x)+'\033[0;39m'
    red = lambda x: '\033[31m' + str(x)+'\033[0;39m'
    green = lambda x: '\033[32m' + str(x)+'\033[0;39m'
    yellow = lambda x: '\033[33m' + str(x)+'\033[0;39m'
    blue = lambda x: '\033[34m' + str(x)+'\033[0;39m'
    magenta = lambda x: '\033[35m' + str(x)+'\033[0;39m'
    cyan = lambda x: '\033[36m' + str(x)+'\033[0;39m'
    white = lambda x: '\033[37m' + str(x)+'\033[0;39m'

found = True
cwd = os.getcwd()+os.path.sep

print(color.blue('Working in'), cwd, '\n')

for path in files:
    if not os.path.isfile(path):
        print(color.yellow(path), color.red('[MISSING]'))
        found = False
    else:
        print(path, color.green('[OK]'))

if not found:
    print(color.red('Nothing was done, exiting...'))
    sys.exit(0)

print()
print(color.blue('Writing into'), cwd+output)
print()

target = open(cwd+output, 'wb')

first = True

for file in files:

    source = open(file, 'rb')

    if not first:
        target.write(bytes('\n\n', 'utf-8'))
    target.write(bytes('/*\n'+' '*4+'#'*len(file)+'\n'+' '*4+file+'\n'+' '*4+'#'*len(file)+'\n*/\n\n', 'utf-8'))

    for line in source:
        target.write(line)
    source.close()
    first = False

target.close()



# try:
#     db = get_db()
#     db.cursor().execute(open(output, 'r', encoding="utf-8").read())
#     db.commit()
#     print(color.green('Executed all queries'))
# except Exception as e:
#     print(color.red(e))
