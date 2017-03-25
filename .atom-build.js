module.exports = {
    cmd: "rake",//g++ -Wall test.cpp",
    preBuild: function () {
        // console.log('This is run **before** the build command');
    },
    postBuild: function () {
        // console.log('This is run **after** the build command');
    },
    functionMatch: function (output) {
      const error = /^error: ([^:]+):(\d+):(\d+): (.+)$/;
      var matches = [];
      output.split(/\r?\n/).forEach(line => {
        const error_match = error.exec(line);
        if (error_match) {
          matches.push({
            file: error_match[1],
            line: error_match[2],
            column: error_match[3],
            message: error_match[4]
          });
        }
      });
      return matches;
    }
  };
