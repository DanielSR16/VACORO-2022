RegExp expresionRegular = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

RegExp expressionRegularPassword = RegExp(
    r'((?=.*[a-z])(?=.*[A-Z])(?=.*[\$@\$!%*?&\#¿\¡])(?=.*[0-9]))\S{8,15}$');
