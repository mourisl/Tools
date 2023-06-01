/*
  "Let the last k characters of read id the same in a bam file.\n"
  Usage: ./a.out input [option] >output. 
  	./a.out -h for help.
*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "sam.h"

#define LINE_SIZE 4097
#define QUEUE_SIZE 1000001
#define HASH_MAX 1000003

#define ABS(x) ((x)<0?-(x):(x))

char line[LINE_SIZE] ;
char strand ; // Extract XS field
bool secondary ;
int mateStart ;

struct _list
{
	bam1_t *b ;
	int start, end ;
	bool keep ;
	struct _list *next ;
} ;

struct _tree
{
	bam1_t *b ;
	int start, end ;
	//bool keep ;
	struct _list *list ;
	struct _tree *left, *right ; 
} ;

int qHead, qTail, qsHead, qsTail ;

samfile_t *fpout ;

void PrintHelp()
{
	printf( 
		"Let the last k characters of read id the same in a bam file.\n"
		"Usage: ./a.out input.bam k\n"
	      ) ;
}

void cigar2string( bam1_core_t *c, uint32_t *in_cigar, char *out_cigar )
{
	int k, op, l ;
	char opcode ;

	*out_cigar = '\0' ;
	for ( k = 0 ; k < c->n_cigar ; ++k )
	{
		op = in_cigar[k] & BAM_CIGAR_MASK ;
		l = in_cigar[k] >> BAM_CIGAR_SHIFT ;
		switch (op)
		{
			case BAM_CMATCH: opcode = 'M' ; break ;
			case BAM_CINS: opcode = 'I' ; break ;
			case BAM_CDEL: opcode = 'D' ; break ;
			case BAM_CREF_SKIP: opcode = 'N' ; break ;
			case BAM_CSOFT_CLIP: opcode = 'S' ; break ;
			case BAM_CHARD_CLIP: opcode = 'H' ; break ;
			case BAM_CPAD: opcode = 'P' ; break ;
		}
		sprintf( out_cigar + strlen( out_cigar ), "%d%c", l, opcode ) ;
	}
}



void OutputTree( struct _tree *t ) 
{
	if ( t == NULL )
		return ;
	//printf( "Remaining\n" ) ;	
	//if ( t->keep )
		samwrite( fpout, t->b ) ;

	OutputTree( t->left ) ;
	OutputTree( t->right ) ;
}

struct _list * OutputList( struct _list *p, int cut, bam1_t *b )
{
	struct _list *q ;
	while ( p != NULL && ( cut == -1 || p->end < cut || p->b->core.tid != b->core.tid ) )
	{
		if ( p->keep )
			samwrite( fpout, p->b ) ;
		bam_destroy1( p->b ) ;
		q = p ;
		p = p->next ;
		free( q ) ; // b is freed by RemoveNode.
	}
	return p ;
}

int main( int argc, char *argv[] ) 
{
	FILE *fp ;
	char *p ;
 	samfile_t *fpsam ;
	bam1_t *b = NULL ;
	struct _tree root ;
	bool useSam = true, hasSplice ;
	char readId[LINE_SIZE] ;
	char cigar[LINE_SIZE] ;
 	int i, len, num ;
 	int start,end ;
	char prevChrome[103] ;
	struct _list *head, *tail, *node ;
	strcpy( prevChrome, "" ) ;
	int removeLength ;
	// processing the argument list
	for ( i = 1 ; i < argc ; ++i )
	{
		if ( !strcmp( argv[i], "-h" ) )
		{
			PrintHelp() ;
			return 0 ;
		}
	}
	if ( argc != 3 )
	{
		PrintHelp() ;
		return 0 ;
	}

	len = strlen( argv[1] ) ;
	if ( !( fpsam = samopen( argv[1], "rb", 0 ) ) )
	{
		printf( "Can not open file %s\n", argv[1] ) ;
		return 0 ;
	}
	removeLength = atoi( argv[2] ) ;

	root.left = NULL ;
	qHead = qTail = qsHead = qsTail = 0 ;
	head = ( struct _list *)malloc( sizeof( *head ) ) ;
	tail = head ;
	head->next = NULL ;

	fpout = samopen( "-", "wb", fpsam->header ) ;
	while ( 1 )
	{
		int flag = 0 ;
		if ( b != NULL )
			bam_destroy1( b ) ;
		b = bam_init1() ;
		if ( samread( fpsam, b ) <= 0 )
			break ;
		p = bam1_qname( b ) + strlen( bam1_qname( b ) ) ;
		//p -= 2 ;
		//*p = '\0' ;
		for ( i = 1 ; i <= removeLength ; ++i )
		{
			*(p - i) = ':' ;
		}
		/*if ( flag & 0x100 )
		  secondary = true ;
		  else 
		  secondary = false ;*/
		/*if ( bam_aux_get( b, "XS" ) )
		{
			strand = bam_aux2A( bam_aux_get( b, "XS" ) ) ;
			if ( strand == argv[2][0] )
				samwrite( fpout, b ) ;
		}*/
		//else
		samwrite( fpout, b ) ;
	}
	//OutputTree( root.left ) ;
	samclose( fpsam ) ;
	samclose( fpout ) ;
	//fprintf( stderr, "The number of junctions: %d\n", junctionCnt ) ;
	return 0 ;
}

