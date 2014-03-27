
SurveyQuestionCollection = new Meteor.Collection 'SurveyQuestion'

if SurveyQuestionCollection.find().count() is 0
  SurveyQuestionCollection.insert _id: '0', questionText: 'What is your favorite color?'
SurveyEnumeratedResponseCollection = new Meteor.Collection 'SurveyEnumeratedResponse'

if SurveyEnumeratedResponseCollection.find().count() is 0
  for o in [
          { value: 'red', title: 'Red', style: "background: red;" }
          { value: 'green', title: 'Green', style: "background: green;" }
          { value: 'blue', title: 'Blue', style: "background: blue; color: white;" }
          { value: 'cantdecide', title: "I can't decide", style: """
            background: red; /* uh oh */
            background: -moz-linear-gradient(left,
                rgba(255, 0, 0, 1) 0%,
                rgba(255, 255, 0, 1) 15%,
                rgba(0, 255, 0, 1) 30%,
                rgba(0, 255, 255, 1) 50%,
                rgba(0, 0, 255, 1) 65%,
                rgba(255, 0, 255, 1) 80%,
                rgba(255, 0, 0, 1) 100%);
            background: -webkit-gradient(linear,  left top, right top,
                color-stop(0%, rgba(255, 0, 0, 1)),
                color-stop(15%, rgba(255, 255, 0, 1)),
                color-stop(30%, rgba(0, 255, 0, 1)),
                color-stop(50%, rgba(0, 255, 255, 1)),
                color-stop(65%, rgba(0, 0, 255, 1)),
                color-stop(80%, rgba(255, 0, 255, 1)),
                color-stop(100%, rgba(255, 0, 0, 1)));
            """
          }]
      SurveyEnumeratedResponseCollection.insert o


