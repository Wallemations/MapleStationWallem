import { Box, Button, Section, Table, Icon } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  all_drinks: Drink[];
};

type Drink = {
  name: string;
  desc: string;
  recipe?: string[];
  alcohol: number;
  icon?: string;
  icon_state?: string;
};


export const DrinksMenu = (props) => {
  const { data } = useBackend<Data>();
  const { all_drinks } = data;

  return (
    <Window width={335} height={335}>
      <Window.Content scrollable>
        <Section
          title="Drinks Menu"
        >
          <Table>
            {!!all_drinks.length && (
              <Table.Row>
              </Table.Row>
            )}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
