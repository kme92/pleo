//
// main.p
// PDK File API example
// Very simple main.p and file example. Simple usage of basic file API's.
//
// This is a simple example of how to use Pleo's basic file API. 
// In this example, we demonstrate how to:
//  - create a new file
//  - open and close the file
//  - add a string to the file
//  - validate the file exists and get its size
//  - delete the file and verify that it is gone
//

// Save space by packing all strings.
#pragma pack 1

// Set a consistent tabsize.
#pragma tabsize 0

// Include API functionality.
#include <Log.inc>
#include <File.inc>
#include <String.inc>
#include <Script.inc>

// This variable is used to record if we've already executed the file operations.
new executed = false;

//
// init
//
public init()
{

    printf("file_test:init\n");

}

//
// main
// Performs the basic file operations.
//
public main()
{

    // LifeOS is designed to run the main() function of the main script 
    // over and over again.  This bit of code keeps the file operations from
    // running more than once.
    if (executed)
    {
        return;
    }

    // We want to use the SD card for our test.
    device_change(device_sd);

    // Create a new File, called "samplefile.txt,"
    // and open it in read/write mode
    new file_name[] = "samplefile.txt";
    printf("Opening a file called %s in read/write mode...\n", file_name);
    new File: write_handle = file_open(file_name, io_write);

    // If the write handle exists, then we perform our file operations on it.
    if (write_handle)
    {

        // Write a data string to the file and close the file.
        // file_puts returns the number of characters that were written to the file.
        printf("Writing to %s and closing it...\n", file_name);
        new write_count = file_puts(write_handle,"0123456789"); 
        printf("%d characters written to file\n", write_count);
        file_close(write_handle);

        // Check that the file exists and report it.  If it 
        // exists, then file_exists should return 1.
        new exists = file_exists(file_name);
        printf("If the file exists, file_exists should return 1.\n");
        printf("file_exists returned %d\n", exists);

        // Report the size of the file.
        new filesize = file_get_size(write_handle);
        printf("The size of the file is %d\n", filesize);

        // Open the file in read mode, read the file's contents
        // into a variable called string_buffer,
        // and verify that the contents are correct.
        printf("Opening %s in read mode...\n", file_name);
        write_handle = file_open(file_name, io_read); 

        new string_buffer[32];
        new read_count = file_gets(write_handle, string_buffer, true);
 
        printf("file_gets returned %s (%d characters read [%d max])\n", string_buffer, read_count, sizeof(string_buffer));

        if (read_count > 0)
        {
            new result = string_compare(string_buffer,"0123456789");
            printf("If we read the correct string from the file, string_compare should return 0.\n");
            printf("string_compare returned %d\n", result); 
        }

        // Close the file, delete it, and make sure it doesn't exist
        printf("Closing %s...\n", file_name);
        file_close(write_handle);

        //printf("Deleting %s...\n", file_name);
        //file_delete(file_name);

        exists = file_exists(file_name);
        printf("If the file doesn't exist, file_exists should return 0.\n");
        printf("file_exists returned %d\n", exists);

        // By setting executed to true, we prevent the VM from running the file
        // operations over again.
        executed = true;

    }
    else
    {
    
        printf("File handle not successfully opened\n");
        
    }

}


// 
// close
//
public close()
{

    printf("file_test:close\n");

}

