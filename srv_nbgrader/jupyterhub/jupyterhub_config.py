from subprocess import check_call
def my_hook(spawner):
    username = spawner.user.name
    check_call(['/opt/jupyter.sh', username])

c = get_config()

c.Authenticator.whitelist = [
    'instructor1',
    'student1',
    'ashriram',
    'diana',
    'bobbyc'
]


c.Spawner.pre_spawn_hook = my_hook

#c.LocalProcessSpawner.term_timeout = 5

c.JupyterHub.load_groups = {
    'formgrader-course101': [
        'ashriram',
        'diana',
        'bobbyc'
    ]
}

c.JupyterHub.services = [
    {
        'name': 'course101',
        'url': 'http://127.0.0.1:9999',
        'command': [
            'jupyterhub-singleuser',
            '--group=formgrader-course101',
            '--debug',
        ],
        'user': 'anaconda',
        'cwd': '/home/anaconda'
    }
]
