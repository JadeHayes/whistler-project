import scrapy


class WhistlerSpider(scrapy.Spider):
    # Name our scrapper will refer to when starting
    name = "whistler"

    def start_requests(self):
        # urls we are going to scrape content from
        urls = [
            'https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/terrain-and-lift-status.aspx',
            'https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/snow-and-weather-report.aspx',
        ]
        # Loop through each url and make a request and pass url & callack function
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)

    # Will parse through the page
    def parse(self, response):
        #will check url, split url by "/" and extracting the last 6 characters
        page = response.url.split("/")[-1][-11:-5]
        filename = 'whistler-{}.html'.format(page)
        # will store html content into file
        with open(filename, 'wb') as f:
            # writing all html to file name
            f.write(response.body)
        self.log('Saved file {}'.format(filename))
