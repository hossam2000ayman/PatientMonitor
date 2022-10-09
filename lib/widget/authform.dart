import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  AuthForm({ required this.submitFn, required this.isLogin});
final void Function(String email,String password,String username,bool isLoging,BuildContext ctx) submitFn;
 final bool isLogin;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

    final _formKey=GlobalKey<FormState>();
    bool logIn=true;
    String _userEmail='';
    String _userUsername='';
    String _userPassword='';

    void _trySubmit()
    {

      final isvalid=_formKey.currentState!.validate();

      if(isvalid)
      {
        _formKey.currentState!.save();
        print(_userEmail);
        print(_userUsername);
        print(_userPassword);
        widget.submitFn(_userEmail.trim(),_userPassword.trim(),_userUsername.trim(),logIn,context);
      }
    }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey("useremail"),
                  validator: (value){
                    if(value!.isEmpty|| !value.contains('@'))
                    {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",

                  ),
                  onSaved: (val){
                    _userEmail=val!;
                  },
                ),
                if(!logIn)
                  TextFormField(
                    key:ValueKey("username"),
                    validator: (value){
                      if(value!.isEmpty|| value.length<4)
                      {
                        return 'Please Enter userId with 4 char atleast';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                    onSaved: (val){
                      _userUsername=val!;
                    },
                  ),
                TextFormField(
                  key:ValueKey("password"),
                  validator: (value){
                    if(value!.isEmpty||value.length<7)
                    {
                      return'Password atleast 7 char long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                  onSaved: (val){
                    _userPassword=val!;
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  child:widget.isLogin?CircularProgressIndicator():Text(logIn?"Login":"Sign Up") ,
                  onPressed: (){_trySubmit();},
                ),
                MaterialButton(

                  child: Text(logIn?"Craete An Account":"I already Have an Account"),
                  onPressed: (){
                    if(mounted)
                      {
                        setState(() {
                          logIn=!logIn;
                        });
                      }

                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

