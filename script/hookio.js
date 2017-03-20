// hook.io microservice for infra operations, listens to webhooks from Slack & pass
// them to Circle-CI
module['exports'] = function ceribroAction (hook) {

  var request = require('request');
  var params = hook.params;

  // check if call was made from SLACK
  if(params.token === hook.env.SLACK_TOKEN) {
    // build POST req

    var req = {
    	'uri': hook.env.CI_URL + hook.env.CI_TOKEN,
      	'method': 'POST',
      	'headers': {
          'Content-Type': 'application/json'
        },
      	'json': {
          'build_parameters': { 'ANSIBLE_ACTION': params.text || ''}
        }
    };

    // make the request
    request(req, function(err, res, body){
    	if(err) {
        	hook.res.end(err);
        } else {
        	hook.res.end(body);
        }
    });
  } else {
  	// if wrong slack token
    hook.res.end('Invalid token!');
  }
};
