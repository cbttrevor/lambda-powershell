using Amazon.Lambda.PowerShellHost;

namespace EC2Shutdown
{
    public class Bootstrap : PowerShellFunctionHost
    {
        public Bootstrap() : base("Basic.ps1")
        {
        }
    }
}
