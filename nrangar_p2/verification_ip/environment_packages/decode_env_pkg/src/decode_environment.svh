class decode_environment extends uvm_env;
    `uvm_component_utils(decode_environment)

    decode_in_agent agent;
    decode_out_agent agento;
    decode_predictor predictor;
    decode_scoreboard scoreboard;

    function new(string name = "decode_environment", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase); 
        super.build_phase(phase);
        agent = decode_in_agent::type_id::create("agent", this);
        agento = decode_out_agent::type_id::create("agento", this); 
        predictor = decode_predictor::type_id::create("predictor", this);
        scoreboard = decode_scoreboard::type_id::create("scoreboard", this);  
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.decode_in_ap.connect(predictor.analysis_export);
        predictor.predictor_ap.connect(scoreboard.expected);
        agento.decode_out_ap.connect(scoreboard.actual);
    endfunction
endclass