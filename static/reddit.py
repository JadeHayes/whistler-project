import praw


# gain access to reddit through their API
reddit = praw.Reddit(client_id ='ya-InTZTrhfsfQ',
                     client_secret='OaaNIVoyqkAoc9H9TbXbb2289DY',
                     username='EmergencyAsk',
                     whoopsword='password',
                     user_agent='yaaaaaayayayay')

# get the subreddit we want to access & limit to 20 posts
sub = reddit.subreddit('LetsGoSnowboarding')
posts = sub.hot(limit=20)

# loop over the sumissions objects in the posts
for submission in posts:

    # grab the comments out of the submission obj and split
    comments = submission.comments
    for comment in comments:
        print '|'
        print comment.body.encode('utf8')
