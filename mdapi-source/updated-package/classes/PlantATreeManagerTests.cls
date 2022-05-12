@isTest
public class PlantATreeManagerTests
{

	@isTest static void testPlantATreeManagerPlural()
	{
		//mock http
		Test.setMock(HttpCalloutMock.class, new PlantATreeApiMock ());

		List<PlantTreeRequest> input = new List<PlantTreeRequest>();
		PlantTreeRequest item = new PlantTreeRequest();
		item.OpportunityName = 'test';
		input.add(item);


		PlantATreeManager.CallPlantATreeAPI(input);
	}



	@isTest static void testPlantATreeManagerSingle()
	{
		//mock http
		Test.setMock(HttpCalloutMock.class, new PlantATreeApiMock ());

		PlantTreeRequest item = new PlantTreeRequest();
		item.OpportunityName = 'test';

		item.TotalTrees= 1;
		PlantTreeResponse output = PlantATreeManager.CallPlantATreeAPI(item);
		System.debug(output.Message);
	}

	@isTest
	static void GetSettings()
	{
		Plant_A_Tree_Settings__mdt output = PlantATreeManager.GetSettings();
	}
}