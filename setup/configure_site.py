import argparse
import jinja2
import json
import os

parser = argparse.ArgumentParser()
parser.add_argument('--ip')
parser.add_argument('--port')
parser.add_argument('--base_url')
parser.add_argument('--token')
parser.add_argument('--project_name')
parser.add_argument('--username')
parser.add_argument('--return_url')
parser.add_argument('--manage_url')

def render(tpl_path, context):
    path, filename = os.path.split(tpl_path)
    return jinja2.Environment(
        loader=jinja2.FileSystemLoader(path or './')
    ).get_template(filename).stream(context).dump(tpl_path)

if __name__ == '__main__':
    args, unknown = parser.parse_known_args()
    render('/etc/nginx/sites-available/site', {'base_url': args.base_url, 'port': args.port})
    render('/var/www/devbowl/index.html', {'project_name': args.project_name, 'username': args.username, 'return_url': args.return_url, 'manage_url' : args.manage_url})

    # Find all folders projects and add them to the codiad data.
    files = os.scandir(path='/home/user/projects')
    directories = filter(lambda f: f.is_dir(), files)

    projects = []
    for directory in directories:
        project = {
            'name': directory.name,
            'path': directory.path,
        }
        projects.append(json.dumps(project))

    render('/var/www/html/data/projects.php', {'projects': projects})
