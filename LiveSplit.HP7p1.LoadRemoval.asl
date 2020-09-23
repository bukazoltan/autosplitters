// Loadremoval created by Flo203 and marczeslaw

state("hp7")
{
bool isLoading1: 0x39C110;
bool isLoading2: 0x39C0F8;
}

isLoading
{
    return current.isLoading1 || current.isLoading2;
}    