const aws = require('aws-sdk');
const moment = require('moment');
const { chromium } = require('playwright-core');
const awsChromium = require('chrome-aws-lambda');

const s3 = new aws.S3({ 
    apiVersion: '2006-03-01',
    endpoint: `http://${process.env.LOCALSTACK_HOSTNAME}:4566`, // This two lines are
    s3ForcePathStyle: true,                                     // only needed for LocalStack. 
});

const bucket = "screenshots";

exports.handler = async (event, context) => {
    const url = decodeURIComponent(event.Records[0].body);

    console.log(`URL to query: ${url}`);

    let browser = null;

    try {
        browser = await chromium.launch({
            headless: true,
            executablePath: await awsChromium.executablePath,
            args: ["--no-sandbox", "--no-zygote", "--single-process"]
        });

      console.log("Browser launched");

      const context = await browser.newContext();

      console.log("Context created");
  
      const page = await context.newPage();

      console.log("Page created");

      await page.goto(url);

      console.log("Title: " + await page.title() );
  
      const file = moment(new Date()).format("DDMMYYYYhmmss") + ".png";

      await page.screenshot({ path: file, fullPage: true });

      const params = {
        Bucket: bucket,
        Key: file,
        Body: fs.readFileSync(file),
      };

    s3.upload(params, function(err, data) {
        if (err) {
            throw err;
        }
        console.log(`File uploaded successfully. aws ${data.Location}`);
    });

    } catch (error) {
      console.log(error);
    } finally {
      if (browser) {
        await browser.close();
      }
    }
};