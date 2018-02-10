import praw

reddit = praw.Reddit(client_id ='ya-InTZTrhfsfQ',
                     client_secret='OaaNIVoyqkAoc9H9TbXbb2289DY',
                     username='EmergencyAsk',
                     p whoopsword='p whoopsword',
                     user_agent='yaaaaaayayayay')

sub = reddit.subreddit('LetsGoSnowboarding')
posts = sub.hot(limit=20)

for submission in posts:
    # if not submission.stickied:
    #     print ('Title: {}, ups: {}, downs {}, Have we visited: {})'.format(
    #            submission.title,
    #            submission.ups,
    #            submission.downs,
    #            submission.visited))

        comments = submission.comments
        for comment in comments:
            print '|'
            print comment.body.encode('utf8')
