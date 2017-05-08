/* (Re)Generates errlibt.s and errlibt.inc */
/* Yes, most of those were generated by this */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char errnos[134][17] = {
  "ESUCC",
  "EPERM",
  "ENOENT",
  "ESRCH",
  "EINTR",
  "EIO",
  "ENXIO",
  "E2BIG",
  "ENOEXEC",
  "EBADF",
  "ECHILD",
  "EAGAIN",
  "ENOMEM",
  "EACCES",
  "EFAULT",
  "ENOTBLK",
  "EBUSY",
  "EEXIST",
  "EXDEV",
  "ENODEV",
  "ENOTDIR",
  "EISDIR",
  "EINVAL",
  "ENFILE",
  "EMFILE",
  "ENOTTY",
  "ETXTBSY",
  "EFBIG",
  "ENOSPC",
  "ESPIPE",
  "EROFS",
  "EMLINK",
  "EPIPE",
  "EDOM",
  "ERANGE",
  "EDEADLK",
  "ENAMETOOLONG",
  "ENOLCK",
  "ENOSYS",
  "ENOTEMPTY",
  "ELOOP",
  "EUNKNOWNERR",
  "ENOMSG",
  "EIDRM",
  "ECHRNG",
  "EL2NSYNC",
  "EL3HLT",
  "EL3RST",
  "ELNRNG",
  "EUNATCH",
  "ENOCSI",
  "EL2HLT",
  "EBADE",
  "EBADR",
  "EXFULL",
  "ENOANO",
  "EBADRQC",
  "EBADSLT",
  "EUNKNOWNERR",
  "EBFONT",
  "ENOSTR",
  "ENODATA",
  "ETIME",
  "ENOSR",
  "ENONET",
  "ENOPKG",
  "EREMOTE",
  "ENOLINK",
  "EADV",
  "ESRMNT",
  "ECOMM",
  "EPROTO",
  "EMULTIHOP",
  "EDOTDOT",
  "EBADMSG",
  "EOVERFLOW",
  "ENOTUNIQ",
  "EBADFD",
  "EREMCHG",
  "ELIBACC",
  "ELIBBAD",
  "ELIBSCN",
  "ELIBMAX",
  "ELIBEXEC",
  "EILSEQ",
  "ERESTART",
  "ESTRPIPE",
  "EUSERS",
  "ENOTSOCK",
  "EDESTADDRREQ",
  "EMSGSIZE",
  "EPROTOTYPE",
  "ENOPROTOOPT",
  "EPROTONOSUPPORT",
  "ESOCKTNOSUPPORT",
  "EOPNOTSUPP",
  "EPFNOSUPPORT",
  "EAFNOSUPPORT",
  "EADDRINUSE",
  "EADDRNOTAVAIL",
  "ENETDOWN",
  "ENETUNREACH",
  "ENETRESET",
  "ECONNABORTED",
  "ECONNRESET",
  "ENOBUFS",
  "EISCONN",
  "ENOTCONN",
  "ESHUTDOWN",
  "ETOOMANYREFS",
  "ETIMEDOUT",
  "ECONNREFUSED",
  "EHOSTDOWN",
  "EHOSTUNREACH",
  "EALREADY",
  "EINPROGRESS",
  "ESTALE",
  "EUCLEAN",
  "ENOTNAM",
  "ENAVAIL",
  "EISNAM",
  "EREMOTEIO",
  "EDQUOT",
  "ENOMEDIUM",
  "EMEDIUMTYPE",
  "ECANCELED",
  "ENOKEY",
  "EKEYEXPIRED",
  "EKEYREVOKED",
  "EKEYREJECTED",
  "EOWNERDEAD",
  "ENOTRECOVERABLE",
  "ERFKILL",
  "EHWPOISON"
};

const char errcomma[134][17] = {
  "ESUCC,",
  "EPERM,",
  "ENOENT,",
  "ESRCH,",
  "EINTR,",
  "EIO,",
  "ENXIO,",
  "E2BIG,",
  "ENOEXEC,",
  "EBADF,",
  "ECHILD,",
  "EAGAIN,",
  "ENOMEM,",
  "EACCES,",
  "EFAULT,",
  "ENOTBLK,",
  "EBUSY,",
  "EEXIST,",
  "EXDEV,",
  "ENODEV,",
  "ENOTDIR,",
  "EISDIR,",
  "EINVAL,",
  "ENFILE,",
  "EMFILE,",
  "ENOTTY,",
  "ETXTBSY,",
  "EFBIG,",
  "ENOSPC,",
  "ESPIPE,",
  "EROFS,",
  "EMLINK,",
  "EPIPE,",
  "EDOM,",
  "ERANGE,",
  "EDEADLK,",
  "ENAMETOOLONG,",
  "ENOLCK,",
  "ENOSYS,",
  "ENOTEMPTY,",
  "ELOOP,",
  "EUNKNOWNERR,",
  "ENOMSG,",
  "EIDRM,",
  "ECHRNG,",
  "EL2NSYNC,",
  "EL3HLT,",
  "EL3RST,",
  "ELNRNG,",
  "EUNATCH,",
  "ENOCSI,",
  "EL2HLT,",
  "EBADE,",
  "EBADR,",
  "EXFULL,",
  "ENOANO,",
  "EBADRQC,",
  "EBADSLT,",
  "EUNKNOWNERR,",
  "EBFONT,",
  "ENOSTR,",
  "ENODATA,",
  "ETIME,",
  "ENOSR,",
  "ENONET,",
  "ENOPKG,",
  "EREMOTE,",
  "ENOLINK,",
  "EADV,",
  "ESRMNT,",
  "ECOMM,",
  "EPROTO,",
  "EMULTIHOP,",
  "EDOTDOT,",
  "EBADMSG,",
  "EOVERFLOW,",
  "ENOTUNIQ,",
  "EBADFD,",
  "EREMCHG,",
  "ELIBACC,",
  "ELIBBAD,",
  "ELIBSCN,",
  "ELIBMAX,",
  "ELIBEXEC,",
  "EILSEQ,",
  "ERESTART,",
  "ESTRPIPE,",
  "EUSERS,",
  "ENOTSOCK,",
  "EDESTADDRREQ,",
  "EMSGSIZE,",
  "EPROTOTYPE,",
  "ENOPROTOOPT,",
  "EPROTONOSUPPORT,",
  "ESOCKTNOSUPPORT,",
  "EOPNOTSUPP,",
  "EPFNOSUPPORT,",
  "EAFNOSUPPORT,",
  "EADDRINUSE,",
  "EADDRNOTAVAIL,",
  "ENETDOWN,",
  "ENETUNREACH,",
  "ENETRESET,",
  "ECONNABORTED,",
  "ECONNRESET,",
  "ENOBUFS,",
  "EISCONN,",
  "ENOTCONN,",
  "ESHUTDOWN,",
  "ETOOMANYREFS,",
  "ETIMEDOUT,",
  "ECONNREFUSED,",
  "EHOSTDOWN,",
  "EHOSTUNREACH,",
  "EALREADY,",
  "EINPROGRESS,",
  "ESTALE,",
  "EUCLEAN,",
  "ENOTNAM,",
  "ENAVAIL,",
  "EISNAM,",
  "EREMOTEIO,",
  "EDQUOT,",
  "ENOMEDIUM,",
  "EMEDIUMTYPE,",
  "ECANCELED,",
  "ENOKEY,",
  "EKEYEXPIRED,",
  "EKEYREVOKED,",
  "EKEYREJECTED,",
  "EOWNERDEAD,",
  "ENOTRECOVERABLE,",
  "ERFKILL,",
  "EHWPOISON,"
};

int isValid(int num)
{
  return num != 41 && num != 58;
}

int main()
{
  // Open the files
  FILE* file = fopen("errlibt.s", "w"); //Write the error library
  FILE* hfile = fopen("errno.inc", "w");//Write the error library header

  // Write the header
  fprintf(hfile, "/* ERRNO CONSTANTS */\n");

  // Make the macros
  for (int i = 0; i <= 133; i++)
  {
    if (isValid(i))
    {
      fprintf(hfile, ".set\t%-16s%4i  // %s\n", errcomma[i], i, strerror(i));
    }
  }

  // Close errlibt.h
  fclose(hfile);

  // Write the header
  fprintf(file, "/* Error Library (Thumb) */\n/* Depends on Input/Output, Macro, and System Libraries */\n\n.include\t\"../macrolib/macrolib.inc\"\n\n/* FILE STREAMS */\n.set\tSTDOUT, 1\n\n.text\n.thumb\n.syntax\tunified\n\n");

  // Write the code
  fprintf(file, "/* char*[r0] getErr(int errno[r1]) */\n");
  fprintf(file, "/* Returns the pointer to the errno's null-terminated string */\n");
  fprintf(file, "/* Data Races: Only static memory is accessed */\n");
  fprintf(file, ".thumb_func\n");
  fprintf(file, ".global\tgetErr\n");
  fprintf(file, ".type\tgetErr, %%function\n");
  fprintf(file, "getErr:\n");
  fprintf(file, "\tpush\t{r1, lr}\t// Save return point\n");
  fprintf(file, "\tbl\tmakePositive\t// Make the number positive\n");
  fprintf(file, "\tmovs\tr2, #4\n");
  fprintf(file, "\tmul\tr1, r1, r2\t// Multiply the number by 4 (for addresses)\n");
  fprintf(file, "\tmov32\tr2, ERRNO\t// Load the address\n");
  fprintf(file, "\tadds\tr2, r2, r1\t// Add the offset to the address\n");
  fprintf(file, "\tldr\tr0, [r2]\t// Load the string from that address\n");
  fprintf(file, "\tpop\t{r1, pc}\t// Return\n\n");

  fprintf(file, "/* char*[r0] getErrDetails(int errno[r1]) */\n");
  fprintf(file, "/* Returns the pointer to the errno's null-terminated description */\n");
  fprintf(file, "/* Data Races: Only static memory is accessed */\n");
  fprintf(file, ".thumb_func\n");
  fprintf(file, ".global\tgetErrDetails\n");
  fprintf(file, ".type\tgetErrDetails, %%function\n");
  fprintf(file, "getErrDetails:\n");
  fprintf(file, "\tpush\t{r1, lr}\t// Save return point\n");
  fprintf(file, "\tbl\tmakePositive\t// Make the number positive\n");
  fprintf(file, "\tmovs\tr2, #4\n");
  fprintf(file, "\tmul\tr1, r1, r2\t// Multiply the number by 4 (for addresses)\n");
  fprintf(file, "\tmov32\tr2, ERRNODET\t// Load the address\n");
  fprintf(file, "\tadds\tr2, r2, r1\t// Add the offset to the address\n");
  fprintf(file, "\tldr\tr0, [r2]\t// Load the string from that address\n");
  fprintf(file, "\tpop\t{r1, pc}\t// Return\n\n");

  fprintf(file, "/* void fprintErr(int fd[r0], int errno[r1]) */\n");
  fprintf(file, "/* Writes the symbolic message of the error number errno to the stream fd */\n");
  fprintf(file, "/* Data Races: Only static memory is accessed */\n");
  fprintf(file, ".thumb_func\n");
  fprintf(file, ".global\tfprintErr\n");
  fprintf(file, ".type\tfprintErr, %%function\n");
  fprintf(file, "fprintErr:\n");
  fprintf(file, "\tpush\t{r0, r1, lr}\t// Save return point\n");
  fprintf(file, "\tbl\tgetErr\t\t// Get the error string\n");
  fprintf(file, "\tmovs\tr1, r0\n");
  fprintf(file, "\tpop\t{r0}\n");
  fprintf(file, "\tbl\tfprints\t\t// Print the error string\n");
  fprintf(file, "\tpop\t{r1, pc}\t// Return\n\n");

  fprintf(file, "/* void fprintErrDetails(int fd[r0], int errno[r1]) */\n");
  fprintf(file, "/* Writes a detailed description of the error number errno to the stream fd */\n");
  fprintf(file, "/* Data Races: Only static memory is accessed */\n");
  fprintf(file, ".thumb_func\n");
  fprintf(file, ".global\tfprintErrDetails\n");
  fprintf(file, ".type\tfprintErrDetails, %%function\n");
  fprintf(file, "fprintErrDetails:\n");
  fprintf(file, "\tpush\t{r0, r1, lr}\t// Save return point\n");
  fprintf(file, "\tbl\tgetErrDetails\t// Get the error description\n");
  fprintf(file, "\tmovs\tr1, r0\n");
  fprintf(file, "\tpop\t{r0}\n");
  fprintf(file, "\tbl\tfprints\t\t// Print the error description\n");
  fprintf(file, "\tpop\t{r1, pc}\t// Return\n\n");

  fprintf(file, "/* int [r1] makePositive(int num[r1]) */\n");
  fprintf(file, "/* If the number is negative then it will become positive */\n");
  fprintf(file, "/* Data Races: No memory is accessed */\n");
  fprintf(file, ".thumb_func\n");
  fprintf(file, "makePositive:\n");
  fprintf(file, "\tcmp\tr1, #0\t// If r0 is greater or equal to zero then skip\n");
  fprintf(file, "\tbpl\t.LskipPositive\n");
  fprintf(file, "\tneg\tr1, r1\t// Negate the number\n");
  fprintf(file, ".LskipPositive:\n");
  fprintf(file, "\tbx\tlr\t// Return\n\n");

  fprintf(file, "/* void printErr(int errno[r1]) */\n");
  fprintf(file, "/* Prints the symbolic message of the error number errno to the console */\n");
  fprintf(file, "/* Data Races: Only static memory is accessed */\n");
  fprintf(file, ".thumb_func\n");
  fprintf(file, ".global\tprintErr\n");
  fprintf(file, ".type\tprintErr, %%function\n");
  fprintf(file, "printErr:\n");
  fprintf(file, "\tmovs\tr0, #STDOUT\n");
  fprintf(file, "\tb\tfprintErr\n\n");

  fprintf(file, "/* void printErrDetails(int fd[r0], int errno[r1]) */\n");
  fprintf(file, "/* Prints a detailed description of the error number errno to the console */\n");
  fprintf(file, "/* Data Races: Only static memory is accessed */\n");
  fprintf(file, ".thumb_func\n");
  fprintf(file, ".global\tprintErrDetails\n");
  fprintf(file, ".type\tprintErrDetails, %%function\n");
  fprintf(file, "printErrDetails:\n");
  fprintf(file, "\tmovs\tr0, #STDOUT\n");
  fprintf(file, "\tb\tfprintErrDetails\n");

  // Make the data header
  fprintf(file, "\n.data\n");

  // Make the errno jump table
  fprintf(file, "\nERRNO:\n");
  for (int i = 0; i <= 133; i++)
    fprintf(file, "\t.word\t%sSTR\n", errnos[i]);

  // Make the detailed errno jump table
  fprintf(file, "ERRNODET:\n");
  for (int i = 0; i <= 133; i++)
    fprintf(file, "\t.word\t%sDET\n", errnos[i]);

  // Make the errno strings
  fprintf(file, "EUNKNOWNERRSTR:\n\t.asciz\t\"EUNKNOWNERR\"\n");
  for (int i = 0; i <= 133; i++)
  {
    if (isValid(i))
    {
      fprintf(file, "%sSTR:\n\t.asciz\t\"%s\"\n", errnos[i], errnos[i]);
    }
  }

  // Make the detailed errno strings
  fprintf(file, "EUNKNOWNERRDET:\n\t.asciz\t\"Invalid error number\"\n");
  for (int i = 0; i <= 133; i++)
  {
    if (isValid(i))
    {
      fprintf(file, "%sDET:\n\t.asciz\t\"%s\"\n", errnos[i], strerror(i));
    }
  }

  // Close errlibt.s
  fclose(file);
}
