import json
import boto3
import time

def lambda_handler(event, context):
  # TODO implement
  #for looping across the regions
  regionList=[]
  region=boto3.client('ec2')
  regions=region.describe_regions()
  #print('the total region in aws are : ',len(regions['Regions']))
  for r in range(0,len(regions['Regions'])):
      regionaws=regions['Regions'][r]['RegionName']
      regionList.append(regionaws)
  #print(regionList)
  #regionsl=['us-east-1']
  #sending regions as a parameter to the remove_default_vps function
  res=remove_default_vpcs(regionList)


  return {
      'status':res
  }

def get_default_vpcs(client):
  vpc_list = []
  vpcs = client.describe_vpcs(
    Filters=[
      {
          'Name' : 'isDefault',
          'Values' : [
            'true',
          ],
      },
    ]
  )
  vpcs_str = json.dumps(vpcs)
  resp = json.loads(vpcs_str)
  data = json.dumps(resp['Vpcs'])
  vpcs = json.loads(data)

  for vpc in vpcs:
    vpc_list.append(vpc['VpcId'])  

  return vpc_list

def del_igw(ec2, vpcid):
  """ Detach and delete the internet-gateway """
  vpc_resource = ec2.Vpc(vpcid)
  igws = vpc_resource.internet_gateways.all()
  if igws:
    for igw in igws:
      try:
        print("Detaching and Removing igw-id: ", igw.id) 
        igw.detach_from_vpc(
          VpcId=vpcid
        )
        igw.delete(

        )
      except boto3.exceptions.Boto3Error as e:
        print(e)

def delete_default_subnets(ec2_client, vpcid):
  subnet_response = ec2_client.describe_subnets()
  subnet_delete_response = []
  default_subnets = []
  for i in range(0,len(subnet_response['Subnets'])):
      if(subnet_response['Subnets'][i]['VpcId'] == vpcid):
          default_subnets.append(subnet_response['Subnets'][i]['SubnetId'])
  for i in range(0,len(default_subnets)):
      subnet_delete_response.append(ec2_client.delete_subnet(SubnetId=default_subnets[i],DryRun=False))
      
def remove_default_vpcs(res):
  for region in res:
    try:
        client = boto3.client('ec2', region_name = region)
        ec2 = boto3.resource('ec2', region_name = region)
        vpcs = get_default_vpcs(client)
        #delete_vpc_response = ec2_client.delete_vpc(VpcId=default_vpcid,DryRun=False)
        #print("Deleted Default VPC in {}".format(region))
    except boto3.exceptions.Boto3Error as e:
        print(e)
        exit(1)
    else:

        for vpc in vpcs:
            print("\n" + "\n" + "REGION:" + region + "\n" + "VPC Id:" + vpc)
            #del_igw(ec2, vpc)
            #delete_default_subnets(client, vpc)
            time.sleep(10)
            delete_vpc_response = client.delete_vpc(VpcId=vpc,DryRun=False)
            print("Deleted Default VPC in {}".format(region))

print("completed")