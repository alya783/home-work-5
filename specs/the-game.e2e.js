describe('The game', function () {
    it('should get more than 100 points ', async function () {
        await browser.url('https://viktor-silakov.github.io/course-sut/arkanoid.html');
        await browser.pause(1000);
        await $('button=PLAY').click();
        await browser.waitUntil(async () => {
            // player logic
            let ballLocation = await $('#ball').getLocation();
            let padLocation =  await $('#pad').getLocation();
            if(+padLocation.x <= +ballLocation.x){
                await $('#pad').keys('D');       
            } else if(+padLocation.x >= +ballLocation.x) { 
                await $('#pad').keys('A');       
            }
            const points = parseInt(await $('#points').getText(), 10);
            if (points > 100) return true
            console.log({ points })
        }, { timeout: 600000, interval: 10 })
    });
})





