class decode_env_configuration extends uvm_object;
    `uvm_object_utils(decode_env_configuration)

    decode_in_configuration diconfig;
    decode_out_configuration doconfig;

    function new(string name = "decode_env_configuration");
        super.new(name);
        diconfig = decode_in_configuration::type_id::create("diconfig");
        doconfig = decode_out_configuration::type_id::create("doconfig");
    endfunction

    function void initialize(string environment_path, string interface_names[], string interface_activity[]);
        diconfig.initialize({environment_path, ".agent"}, interface_names, interface_activity[0]);
        doconfig.initialize({environment_path, ".agento"},interface_names, interface_activity[1]);
    endfunction
endclass
