class fifo_env extends uvm_env;
    `uvm_component_utils(fifo_env)

    function new(string name = "fifo_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    fifo_agent agnt;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agnt = fifo_agent::type_id::create("agnt", this);
    endfunction

endclass