using System;
// Needed this when attempting to perform a Fortify installation 
// (troubleshooting) on an Azure-hosted virtual machine.
// Yes, we tried many other more sensible approaches first.
// Compiled with Visual Studio 2019 & .NET Framework 4.7.2

namespace SetWinVars
{
    class Program
    {
        static void Main(string[] args)
        {
            if (2 == args.Length)
            {
                Set(args[0], args[1]);
            }
            else
            {
                Console.WriteLine("Pass the variable name and variable value");
            }
        }
        public static void Set(string name, string value)
        {
            Environment.SetEnvironmentVariable(name, value, EnvironmentVariableTarget.Machine);
            Environment.SetEnvironmentVariable(name, value, EnvironmentVariableTarget.Process);
            Environment.SetEnvironmentVariable(name, value, EnvironmentVariableTarget.User);
        }
    }
}
