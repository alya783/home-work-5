// noinspection NpmUsedModulesInstalled
const { When, Then, Given } = require('@cucumber/cucumber');
const YAML = require('yaml');
const { Login } = require("../../src/PO/login.po");
const { CustomPage } = require("../../src/PO/custom_page.po");
const { CustomPage2 } = require("../../src/PO/custom_page_2.po");
const { Table } = require("../../src/PO/tables/table.po");
const Subscribe = require('../../src/PO/forms/subscribe.model');

When(/^I go to "([^"]*)"$/, async function (url) {
    await browser.url(url);
});

When(/^I check the texts of the elements:$/, async function (table) {
    const rows = table.hashes()
    for (const row of rows) {
        expect(await $(row.selector).getText())
            .toEqual(row.text)
    }
});

When(/^I expect element: "([^"]*)" (text|value): "([^"]*)"$/, async function (selector, type, text) {
    const methods = {
        text: 'getText',
        value: 'getValue'
    }
    expect(await $(selector)[methods[type]]())
        .toEqual(text)
});

When('I go to {string} menu item', async function (item){
    await $(`//a[text()[contains(.,"${item}")]]`).click();   
});

When('I login as: {string}, {string}', async function (login, password) {
    await Login.login({ username: login, password: password });
    await $('#user-label').waitForDisplayed({timeoutMsg: 'cannot login into system'});
});

async function invokeMethodOnPo(action, pretext, po, element, parameters) {
    if ('string' === (typeof parameters)) {
        if (parameters.includes('[')) {
            paramsArr = JSON.parse(parameters)
            await eval(po)[element][action](...paramsArr);
            return
        }
        await eval(po)[element][action](parameters);
    }
}

When(/^I (\w+) (on|at|in|into) (\w+) (\w+)(?:| with parameters:)$/, async function (action, pretext, po, element) {
    await invokeMethodOnPo(action, pretext, po, element)
});

When(/^I (\w+) (on|at|in|into) (\w+) (\w+) with parameters: '([^']*)'$/, async function (action, pretext, po, element, parameters) {
    await invokeMethodOnPo(action, pretext, po, element, parameters)
});


When(/^I search for "([^"]*)"$/, async function (text) {
    await CustomPage.search.setValue(text);
    await CustomPage2.header.search.setValue(text);
});

When(/^I sort table by "([^"]*)"$/, async function (name) {
    const data = await Table.data();
    const head = await (await Table.headers()).filter(item => item.name === name)[0].element.click();
    console.log({ head });
    console.log({ data })
    // console.log(JSON.stringify(data));
});

When(/^I fill form:$/, async function (formYaml) {
    this.state.formData = YAML.parse(formYaml);
    for(const key in this.state.formData){
    	await $(`#${key}`).setValue(this.state.formData[key]);
    }
    await $('//button[@class="btn btn-primary mt-3"]').click();
    await $('//*[@id="users-table"]').waitForDisplayed(); 
});

Then (/^I check new user$/, async function (){
    const rowSelector = '//div[@class="tabulator-row tabulator-selectable tabulator-row-even"]'; 
    for(const key in this.state.formData){
        if(key === 'password') continue;
    	let info = await $(rowSelector).$(`[tabulator-field = "${key}"]`).getText();
    	expect(info).toEqual(this.state.formData[key]);
    }
});

Then(/^I get error, when login as:$/, async function (table) {
    const rows = table.hashes();
    for (const row of rows) {
        await Login.login({ username: row.username, password: row.password });
        let  err_message = await $('//*[@id="error"]').getText();
        expect(err_message).toEqual(row.message);
    }
});

