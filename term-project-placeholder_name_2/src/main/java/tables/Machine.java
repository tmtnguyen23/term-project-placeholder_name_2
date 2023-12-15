package tables;

public class Machine 
{
	private int machine_id;
	private String make_model;
	private int runtime;
	
	public Machine(int machine_id, String make_model, int runtime)
	{
		this.machine_id = machine_id;
		this.make_model = make_model;
		this.runtime = runtime;
	}
	
	@Override
	public String toString()
	{
		return "machine id: " + machine_id + ", make_model: " + make_model + "runtime (min): " + runtime;
	}
	
	public int getMachineID() 
	{
		return machine_id;
	}
	
	public String getMakemodel() 
	{
		return make_model;
	}

	public int getRuntime() 
	{
		return runtime;
	}

}
